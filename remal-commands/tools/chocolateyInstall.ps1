$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$commandsPath = "$toolsPath\commands"

Get-ChildItem $commandsPath -Filter "*.cmd" | ForEach-Object {
    Write-Debug "File to be shimmed: $($_.Name)"
    Install-BinFile -Name $_.BaseName -Path $_.FullName
}

Get-ChildItem $commandsPath -Filter "*.ps1" | ForEach-Object {
    Write-Debug "File to be shimmed: $($_.Name)"
    Install-ChocolateyPowershellCommand -PackageName $_.BaseName -PSFileFullPath $_.FullName
}
