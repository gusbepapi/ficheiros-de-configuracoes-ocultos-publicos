# Sourcing the modular shell configuration, in alphabetical order
$modules = Join-Path $HOME '.config/shells/pwsh'

if (Test-Path $modules)
{
  Get-ChildItem -Path $modules -Filter '*.ps1' -File | Sort-Object Name | ForEach-Object { . $_.FullName }
}
