$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$commandsPath = "$toolsPath\commands"

Get-ChildItem $commandsPath -Filter "*.cmd" | ForEach-Object {
  Write-Debug "Removing shimmed file: $($_.Name)"
  Uninstall-BinFile $_.Name
}
