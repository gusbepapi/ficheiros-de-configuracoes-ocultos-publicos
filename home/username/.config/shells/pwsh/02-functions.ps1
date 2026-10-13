#!/usr/bin/env pwsh

# Rendering the distribution variants with the dotdrop delimiters and the variable «distro», which is arch, debian, fedora or void
# This whole file is untested, because PowerShell was not available when it was written

##================##
## Functions
##================##

# Clearing the terminal before each command execution
function cb4
{
  Set-PSReadLineKeyHandler -Key Enter -ScriptBlock {
    [Console]::Write("`e[2J`e[H")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  }
}

# Displaying files with `cat`, deferring to `nvimpager` when the output is a terminal
function catt
{
  if (-not [Console]::IsOutputRedirected -and (Get-Command nvimpager -ErrorAction SilentlyContinue))
  {
    nvimpager -c @args
  }
  else
  {
    /usr/bin/cat @args
  }
}

# Displaying files with `bat`, deferring to `nvimpager` when the output is a terminal
# Debian names the executable `batcat`, so both names are tried
function batt
{
  if (-not [Console]::IsOutputRedirected -and (Get-Command nvimpager -ErrorAction SilentlyContinue))
  {
    nvimpager -c @args
  }
  elseif (Get-Command bat -CommandType Application -ErrorAction SilentlyContinue)
  {
    bat @args
  }
  else
  {
    batcat @args
  }
}

# Encrypting files in tar format with zstd compression
function cgpgtar
{
  param([Parameter(Mandatory = $true)][string]$File)

  # Piping bytes through the shell, because PowerShell would re-encode the stream
  sh -c 'tar cf - --zstd "$1" | gpg -e -z 0 > "$1.tar.zst.gpg"' sh $File
}

# Decrypting files in tar format with zstd compression
function xgpgtar
{
  param([Parameter(Mandatory = $true)][string]$File)

  sh -c 'gpg -d "$1" | tar x --zstd' sh $File
}

# Picking a colour under the cursor, exclusively on Wayland
function cpick
{
  sh -c 'grim -g "$(slurp -p)" -t ppm - | magick convert - -format "%[pixel:p{0,0}]" txt:-'
}

# Reporting the CPU frequency once, rather than continuously watching it
function cpufreq
{
  Select-String -Path /proc/cpuinfo -Pattern 'MHz' | ForEach-Object { $_.Line }
}

# Extracting the video dimensions using `ffprobe` (bundled with `ffmpeg`)
# Usage: get_video_dimension <video_file>
function get_video_dimension
{
  param([Parameter(Mandatory = $true)][string]$File)

  $stream = (ffprobe -v quiet -print_format json -show_format -show_streams $File | ConvertFrom-Json).streams[0]
  "$($stream.width)x$($stream.height)"
}

# Stopping the network time service before the clock is moved back
function _ntp_stop
{
{%@@ if distro == "void" @@%}
  sudo sv stop ntpd
{%@@ elif distro == "fedora" @@%}
  sudo systemctl stop chronyd
{%@@ elif distro == "debian" @@%}
  sudo systemctl stop ntpd 2>$null

  if ($LASTEXITCODE -ne 0)
  {
    sudo systemctl stop systemd-timesyncd
  }
{%@@ else @@%}
  sudo systemctl stop ntpd
{%@@ endif @@%}
}

# Starting the network time service again, once the clock has been resynchronised
function _ntp_start
{
{%@@ if distro == "void" @@%}
  sudo sv start ntpd
{%@@ elif distro == "fedora" @@%}
  sudo systemctl restart chronyd
{%@@ elif distro == "debian" @@%}
  sudo systemctl restart ntpd 2>$null

  if ($LASTEXITCODE -ne 0)
  {
    sudo systemctl restart systemd-timesyncd
  }
{%@@ else @@%}
  sudo systemctl restart ntpd
{%@@ endif @@%}
}

# Resetting the system clock from the date header of a web server
function _clock_from_web
{
  $headers = (wget --method=HEAD -qSO- --max-redirect=0 google.com 2>&1) -join "`n"

  if ($headers -match '(?m)^\s*Date:\s*(?<date>.+)$')
  {
    sudo date -s $Matches['date']
  }
}

# Backdating a file’s creation timestamp, then resynchronising the system clock via NTP
# Usage: modifying_file_creation_date <timestamp> <file>
function modifying_file_creation_date
{
  param([string]$Timestamp, [string]$File)

  _ntp_stop
  sudo date +"%Y-%m-%d %T" -s $Timestamp
  New-Item -ItemType File -Force -Path $File | Out-Null
  _clock_from_web
  _ntp_start
}

# Backdating a folder’s creation timestamp, then resynchronising the system clock via NTP
# Usage: modifying_folder_creation_date <timestamp> <folder>
function modifying_folder_creation_date
{
  param([string]$Timestamp, [string]$Folder)

  _ntp_stop
  sudo date +"%Y-%m-%d %T" -s $Timestamp
  New-Item -ItemType Directory -Force -Path $Folder | Out-Null
  _clock_from_web
  _ntp_start
}

# Backdating a copy’s creation timestamp, then resynchronising the system clock via NTP
# Usage: modifying_copying_creation_date <timestamp> <source> <destination>
function modifying_copying_creation_date
{
  param([string]$Timestamp, [string]$Source, [string]$Destination)

  _ntp_stop
  sudo date +"%Y-%m-%d %T" -s $Timestamp
  Copy-Item -Recurse -Force -Path $Source -Destination $Destination
  _clock_from_web
  _ntp_start
}

# Converting a Unix timestamp into the São Paulo time zone, in ISO 8601 format
function unix2br
{
  param([Parameter(Mandatory = $true)][string]$Timestamp)

  $whole = ($Timestamp -split '\.')[0]
  env TZ=America/Sao_Paulo date -d "@$whole" +"%Y-%m-%dT%H:%M:%S%:z"
}

# Decoding JSON escape sequences into UTF-8 text
function json2utf8
{
  param([Parameter(Mandatory = $true)][string]$Text)

  ('"' + $Text + '"') | ConvertFrom-Json
}

# Searching the `title` and extracting the `create_time` from a JSON file
# Usage: find_title_time <file> <query> [exact|contains]
function find_title_time
{
  param(
    [Parameter(Mandatory = $true)][string]$File,
    [Parameter(Mandatory = $true)][string]$Query,
    [string]$Mode = 'exact'
  )

  if (-not (Test-Path $File -PathType Leaf))
  {
    [Console]::Error.WriteLine("The file «$File» does not exist")
    return 1
  }

  if ($Query -eq '')
  {
    [Console]::Error.WriteLine('The search query is empty')
    return 2
  }

  switch ($Mode)
  {
    'contains'
    {
      $filter = '(if type == "array" then .[] else (.. | objects) end) | select((.title? | type) == "string") | select((.create_time? | type) == "number") | select(.title | contains($q)) | [.title, .create_time] | @tsv'
    }
    'exact'
    {
      $filter = '(if type == "array" then .[] else (.. | objects) end) | select(.title? == $q) | select((.create_time? | type) == "number") | [.title, .create_time] | @tsv'
    }
    default
    {
      [Console]::Error.WriteLine("The mode «$Mode» is not supported, use «exact» or «contains»")
      return 4
    }
  }

  $results = @(jq -r --arg q $Query $filter $File)

  if ($results.Count -eq 0)
  {
    [Console]::Error.WriteLine("No entry matching «$Query» was found in «$File»")
    return 3
  }

  foreach ($row in $results)
  {
    $parts = $row -split "`t"
    "«$($parts[0])» → $(unix2br $parts[1])"
  }
}

# Searching the installed packages by name, retaining coloured output
function pkgsearch-installed
{
  param([Parameter(Mandatory = $true)][string]$Term)

{%@@ if distro == "arch" @@%}
  pacman -Qs --color always -- $Term
{%@@ elif distro == "fedora" @@%}
  dnf list --installed "*$Term*"
{%@@ elif distro == "void" @@%}
  xbps-query -s $Term
{%@@ else @@%}
  $esc = [char]27

  apt search $Term 2>$null | Where-Object { $_ -match '\[installed' } | ForEach-Object {
    if ($_ -match '^(?<name>[^/]+)/(?<rest>\S+)\s+(?<version>.+)\s+\[installed[^\]]*\]$')
    {
      "$esc[1;36m$($Matches['name'])/$esc[1;32m$($Matches['rest'])$esc[0m $esc[1;37m$($Matches['version'])$esc[0m $esc[1;33minstalled$esc[0m"
    }
    else
    {
      $_
    }
  }
{%@@ endif @@%}
}

# Touching files verbosely
function touchv
{
  $result = 0

  foreach ($file in $args)
  {
    try
    {
      if (Test-Path -LiteralPath $file)
      {
        (Get-Item -LiteralPath $file).LastWriteTime = Get-Date
      }
      else
      {
        New-Item -ItemType File -Path $file -ErrorAction Stop | Out-Null
      }

      "touch: created file '$file'"
    }
    catch
    {
      [Console]::Error.WriteLine("touch: cannot touch '$file'")
      $result = 1
    }
  }

  # Setting the exit code instead of returning a value, so that no stray number reaches the output
  $global:LASTEXITCODE = $result
}

# Downloading audio with subtitles embedded, in Brazilian Portuguese
function yt-dlp-pro
{
  param(
    [Parameter(Mandatory = $true)][string]$VideoUrl,
    [string]$CustomTitle
  )

  $arguments = @('--write-auto-subs', '--sub-langs', 'pt', '-x', '--audio-format', 'm4a', '-f', 'best', '-k', '--no-mtime', '--embed-metadata', '--no-overwrites')

  if ($CustomTitle)
  {
    $arguments += @('-o', "$CustomTitle.%(ext)s")
  }

  yt-dlp @arguments $VideoUrl
}
