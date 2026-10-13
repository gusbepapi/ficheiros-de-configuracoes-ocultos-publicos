#!/usr/bin/env pwsh

##================##
## Aliases
##================##

# Coreutils courtesies
# Skipping `ls` and `grep`, because `Get-ChildItem` and `Select-String` are coloured already, and the external `grep` is reachable with its full name
function shutdown
{
  sudo shutdown @args
}

# Replacing «exit» with «:q»
# PowerShell cannot name an alias with a colon, so this entry is left out
