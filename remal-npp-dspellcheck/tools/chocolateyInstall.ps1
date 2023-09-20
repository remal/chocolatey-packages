$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-dspellcheck'
    UnzipLocation = "${toolsPath}/plugins/DSpellCheck"
    Url64bit = 'https://github.com/Predelnik/DSpellCheck/releases/download/v1.5.0/DSpellCheck_x64.zip'
    Checksum64 = 'e906fdd4758732d56e54c9e7ce56be7d9356f818fb6f1710f47fbdca6cbb9a26'
    ChecksumType64 = 'sha256'
    Url = 'https://github.com/Predelnik/DSpellCheck/releases/download/v1.5.0/DSpellCheck_x86.zip'
    Checksum = '16cbb1eddacfc7692007e9c2b73e531ba5a480f1cfa2466c11a34f969780f668'
    ChecksumType = 'sha256'
    SoftwareName = 'remal-npp-dspellcheck*'
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
