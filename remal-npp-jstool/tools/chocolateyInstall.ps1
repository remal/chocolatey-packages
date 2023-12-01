$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-jstool'
    UnzipLocation = "${toolsPath}/plugins/JSMinNPP"
    Url64bit = 'https://sourceforge.net/projects/jsminnpp/files/Uni/JSToolNPP.1.2311.0.uni.64.zip'
    Checksum64 = 'c11d28501fb7301ffcc1ff6ffb5635c6ebe0cab6d0baedb763c82cfe2e76f9ea'
    ChecksumType64 = 'sha256'
    Url = 'https://sourceforge.net/projects/jsminnpp/files/Uni/JSToolNPP.1.2311.0.uni.32.zip'
    Checksum = '0b6a5cc5e99bdcbce6d198267eafc21ede966b533a0178ac896204661080dd33'
    ChecksumType = 'sha256'
    SoftwareName = 'remal-npp-jstool*'
}
Install-ChocolateyZipPackage @packageArgs

Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Warning "Closing running instances of Notepad++, please save your files"
    $_.CloseMainWindow() | Out-Null
}
Start-Sleep -Milliseconds 500
if ($VerbosePreference){
    Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue
}
Copy-Item -Path $toolsPath/* -Include $assetsToCopy -Destination $NotepadPlusPlusApplicationPath -Force -Recurse -Confirm:$False -Verbose:$VerbosePreference
