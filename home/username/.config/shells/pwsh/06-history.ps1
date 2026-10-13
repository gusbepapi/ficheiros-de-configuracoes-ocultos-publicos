#!/usr/bin/env pwsh

# Configuring the history of PowerShell, with the closest equivalent of the Bash history file
# PSReadLine keeps one history file for all sessions, so the one-file-per-session archive of Bash is not translated

# Retaining every command without ceiling, as far as PSReadLine allows
Set-PSReadLineOption -MaximumHistoryCount 1000000
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally

# Searching the complete history archive on disk
# Usage: histsearch <pattern>
function histsearch
{
  param([Parameter(Mandatory = $true)][string]$Pattern)

  Select-String -Path (Get-PSReadLineOption).HistorySavePath -Pattern $Pattern -CaseSensitive:$false |
    ForEach-Object { $_.Line } |
    Sort-Object -Unique
}
