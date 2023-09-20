$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-compare'
    UnzipLocation = "${toolsPath}/plugins/ComparePlugin"
    Url64bit = 'https://github.com/pnedev/compare-plugin/releases/download/v2.0.2/ComparePlugin_v2.0.2_X64.zip'
    Checksum64 = '4151fbc9778047991cf4b900363d846bda5b0d1783e5fed9eb77e4c8253ba315'
    ChecksumType64 = 'sha256'
    Url = 'https://github.com/pnedev/compare-plugin/releases/download/v2.0.2/ComparePlugin_v2.0.2_x86.zip'
    Checksum = 'ea2f4cd6627c1b902f700a43b03b38f725e67136c8ce00ac3620ecc03417332a'
    ChecksumType = 'sha256'
    SoftwareName = 'remal-npp-compare*'
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
