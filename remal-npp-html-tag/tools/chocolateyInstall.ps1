$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-html-tag'
    UnzipLocation = "${toolsPath}/plugins/HTMLTag"
    Url64bit = 'https://bitbucket.org/rdipardo/htmltag/downloads/HTMLTag_v1.5.4_x64.zip'
    Checksum64 = '7d296da00b41efdc515888e8ce060bbf0b4b22ec1b778045095886c9932620f2'
    ChecksumType64 = 'sha256'
    Url = ''
    Checksum = ''
    ChecksumType = 'sha256'
    SoftwareName = 'remal-npp-html-tag*'
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
