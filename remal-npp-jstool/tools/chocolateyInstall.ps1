﻿$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-jstool'
    UnzipLocation = "${toolsPath}/plugins/JSMinNPP"
    Url64bit = 'https://sourceforge.net/projects/jsminnpp/files/Uni/JSToolNPP.1.2503.0.uni.64.zip'
    Checksum64 = 'a0c3812a4694400878dfbbebf65a31ec2e5ef9a5ec1f2565ca6abc06d3399092'
    ChecksumType64 = 'sha256'
    Url = 'https://sourceforge.net/projects/jsminnpp/files/Uni/JSToolNPP.1.2503.0.uni.32.zip'
    Checksum = 'b54ca763ea970ba776e779fdcc631c0e441dca4ab55995491ab4a5763aef3af4'
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
