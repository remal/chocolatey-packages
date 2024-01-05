$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-jstool'
    UnzipLocation = "${toolsPath}/plugins/JSMinNPP"
    Url64bit = 'https://sourceforge.net/projects/jsminnpp/files/Uni/JSToolNPP.1.2312.0.uni.64.zip'
    Checksum64 = 'bc819fad1a12a6a29392ad67dfb88d730bb8ac4ecee98f47bb73a0fab387c63e'
    ChecksumType64 = 'sha256'
    Url = 'https://sourceforge.net/projects/jsminnpp/files/Uni/JSToolNPP.1.2312.0.uni.32.zip'
    Checksum = 'dc46e2bf466bd6431351e73bc332e47134b5e04d3c79cfc4738b79ecfed050ed'
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
