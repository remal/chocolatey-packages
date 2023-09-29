$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-markdown-panel'
    UnzipLocation = "${toolsPath}/plugins/NppMarkdownPanel"
    Url64bit = 'https://github.com/mohzy83/NppMarkdownPanel/releases/download/0.7.3.1/NppMarkdownPanel-0.7.3.0-x64.zip'
    Checksum64 = 'f599299a0020cd0ceb812bfe5c52aa5f6c29bf5628ca8b00dff70decb0193e89'
    ChecksumType64 = 'sha256'
    Url = 'https://github.com/mohzy83/NppMarkdownPanel/releases/download/0.7.3.1/NppMarkdownPanel-0.7.3.0-x86.zip'
    Checksum = '477c3056692fb29b588b07aaa6d18a4079a5f2ff781de63c8d23a5f37830f3d5'
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
