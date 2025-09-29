$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-markdown-panel'
    UnzipLocation = "${toolsPath}/plugins/NppMarkdownPanel"
    Url64bit = 'https://github.com/mohzy83/NppMarkdownPanel/releases/download/0.9.0/NppMarkdownPanel-0.9.0.0-x64.zip'
    Checksum64 = '134c2eaf09f72097bf17e2cc41d8a63e57ca4a3d5a221f1e867538629d92189c'
    ChecksumType64 = 'sha256'
    Url = 'https://github.com/mohzy83/NppMarkdownPanel/releases/download/0.9.0/NppMarkdownPanel-0.9.0.0-x86.zip'
    Checksum = '45004f2b0285365de03c246ead6295462b0898004461c313be14be519c522c34'
    ChecksumType = 'sha256'
    SoftwareName = 'remal-npp-markdown-panel*'
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
