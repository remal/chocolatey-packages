﻿$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-jstool'
    UnzipLocation = "${toolsPath}/plugins/JSMinNPP"
    Url64bit = 'https://sourceforge.net/projects/jsminnpp/files/Uni/JSToolNPP.1.2308.0.uni.64.zip'
    Checksum64 = '0937cc056dcd936ba99a92ee4b5850e9e097ba413f200e4fe7475786267661c7'
    ChecksumType64 = 'sha256'
    Url = 'https://sourceforge.net/projects/jsminnpp/files/Uni/JSToolNPP.1.2308.0.uni.32.zip'
    Checksum = 'b1c3ab7d1041bd58f2fafdce1858a5dfe16a166e5f831e6340ddb5c79335d003'
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
