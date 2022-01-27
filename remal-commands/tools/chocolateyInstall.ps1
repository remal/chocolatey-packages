$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$commandsPath = "$toolsPath\commands"

Get-ChildItem $commandsPath -Filter "*.cmd" | ForEach-Object {
  Write-Debug "File to be shimmed: $($_.Name)"
  Install-BinFile $_.BaseName $_.FullName
}
