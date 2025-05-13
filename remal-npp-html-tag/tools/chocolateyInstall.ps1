$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-html-tag'
    UnzipLocation = "${toolsPath}/plugins/HTMLTag"
    Url64bit = 'https://bitbucket.org/rdipardo/htmltag/downloads/HTMLTag_v1.5.2_x64.zip'
    Checksum64 = '5138950112dadb99ac24c991f779e0fb8e9087ec43f54ca02997360fbca916ab'
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
