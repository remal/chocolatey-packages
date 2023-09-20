$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-hex-editor'
    UnzipLocation = "${toolsPath}/plugins/HexEditor"
    Url64bit = 'https://github.com/chcg/NPP_HexEdit/releases/download/0.9.12/HexEditor_0.9.12_x64.zip'
    Checksum64 = '8a5076ad37c1675b2848f5f34b25e4e78af454c441718cfddc663dee5f698bf9'
    ChecksumType64 = 'sha256'
    Url = 'https://github.com/chcg/NPP_HexEdit/releases/download/0.9.12/HexEditor_0.9.12_Win32.zip'
    Checksum = '266be61339df9d7a781ca6f5853ac03db1e35c3c6c1c8bcb2349c619f981c781'
    ChecksumType = 'sha256'
    SoftwareName = 'remal-npp-hex-editor*'
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
