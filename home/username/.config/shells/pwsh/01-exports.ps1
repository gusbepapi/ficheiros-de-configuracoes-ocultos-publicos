#!/usr/bin/env pwsh

##================##
## Exports
##================##

# Adding a directory to the path, at the front unless «-Append» is given, and only once
function Add-ToPath
{
  param(
    [Parameter(Mandatory = $true)][string]$Directory,
    [switch]$Append
  )

  $separator = [System.IO.Path]::PathSeparator
  $entries = @($env:PATH -split [regex]::Escape($separator) | Where-Object { $_ -ne $Directory })

  if ($Append)
  {
    $env:PATH = (($entries + $Directory) -join $separator)
  }
  else
  {
    $env:PATH = ((@($Directory) + $entries) -join $separator)
  }
}

# Setting the Wayland/GTK portal preference, since this session runs exclusively on Hyprland
$env:GTK_USE_PORTAL = '1'

# Setting the Qt6 platform theme
$env:QT_QPA_PLATFORMTHEME = 'qt6ct'

# Overriding the ROCm architecture target for the RDNA-1 RX 5700 XT
$env:HSA_OVERRIDE_GFX_VERSION = '10.3.0'

# Setting the path, so it includes the user’s private «bin» folder if it exists
$localBin = Join-Path $HOME '.local/bin'

if (Test-Path $localBin)
{
  Add-ToPath $localBin

  if (Test-Path (Join-Path $localBin 'official-executables'))
  {
    Add-ToPath (Join-Path $localBin 'official-executables')
  }

  if (Test-Path (Join-Path $localBin 'personal-executables'))
  {
    Add-ToPath (Join-Path $localBin 'personal-executables')
  }

  # MiKTeX, using its custom, non-default link-target directory
  if (Test-Path (Join-Path $localBin 'miktex'))
  {
    Add-ToPath (Join-Path $localBin 'miktex')
  }
}

# Bun
if (Test-Path (Join-Path $HOME '.bun'))
{
  $env:BUN_INSTALL = Join-Path $HOME '.bun'
  Add-ToPath (Join-Path $env:BUN_INSTALL 'bin')
}

# Cargo
if (Test-Path (Join-Path $HOME '.cargo/bin'))
{
  Add-ToPath (Join-Path $HOME '.cargo/bin')
}

# Deno
if (Test-Path (Join-Path $HOME '.deno'))
{
  $env:DENO_INSTALL = Join-Path $HOME '.deno'
  Add-ToPath (Join-Path $env:DENO_INSTALL 'bin')
}

# Mise, a polyglot tool version manager, replacing NVM, PNPM’s installer, etc
if (Get-Command mise -ErrorAction SilentlyContinue)
{
  (& mise activate pwsh) -join "`n" | Invoke-Expression

  # Golang, when provisioned through Mise
  $goInstalls = Join-Path $HOME '.local/share/mise/installs/go'

  if (Test-Path $goInstalls)
  {
    $env:GOPATH = Join-Path $goInstalls 'pkgs'
  }
}

# Poetry, exported rather than installed via `pip`
$env:POETRY_HOME = Join-Path $HOME '.local/bin/python-executables/poetry'

if (Test-Path (Join-Path $env:POETRY_HOME 'bin'))
{
  Add-ToPath (Join-Path $env:POETRY_HOME 'bin')
}

# Poetry's internal venv
if (Test-Path (Join-Path $env:POETRY_HOME 'venv/bin'))
{
  Add-ToPath (Join-Path $env:POETRY_HOME 'venv/bin') -Append
}

# Qt6 tooling
if (Test-Path '/usr/lib/qt6/bin')
{
  Add-ToPath '/usr/lib/qt6/bin'
}

##================##
## Environment secrets
##================##

# Loading a file of «KEY=value» lines, since PowerShell cannot source the POSIX syntax
# Supporting «export KEY=value», single and double quotes, comments and empty lines, but no variable expansion
function Import-EnvFile
{
  param([Parameter(Mandatory = $true)][string]$Path)

  if (-not (Test-Path $Path))
  {
    return
  }

  foreach ($line in (Get-Content -Path $Path))
  {
    $text = $line.Trim()

    if ($text -eq '' -or $text.StartsWith('#'))
    {
      continue
    }

    $text = $text -replace '^export\s+', ''

    if ($text -match '^(?<key>[A-Za-z_][A-Za-z0-9_]*)=(?<value>.*)$')
    {
      $value = $Matches['value'] -replace '^"(.*)"$', '$1' -replace "^'(.*)'$", '$1'
      Set-Item -Path ("Env:" + $Matches['key']) -Value $value
    }
  }
}

# Loading the public, private and secret environment variables
Import-EnvFile (Join-Path $HOME '.env')
Import-EnvFile (Join-Path $HOME '.env.private')
Import-EnvFile (Join-Path $HOME '.env.secrets')
