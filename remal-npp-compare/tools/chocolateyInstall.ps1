$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
  PackageName = 'npp-compare'
  UnzipLocation = "${toolsPath}/plugins/ComparePlugin"
  Url64bit = 'https://github.com/pnedev/compare-plugin/releases/download/v2.0.1/ComparePlugin_v2.0.1_X64.zip'
  Checksum64 = '77DEDF98EA2280528D726C0053DB2001E90DA7588E14EE01A98933F121BB15CB'
  ChecksumType64 = 'sha256'
  Url = 'https://github.com/pnedev/compare-plugin/releases/download/v2.0.1/ComparePlugin_v2.0.1_x86.zip'
  Checksum = '07972C1C7E3012A46AC6EF133A6500CA851BDDC9C83471DF2F118519A0241ED5'
  ChecksumType = 'sha256'
  SoftwareName = 'npp-compare*'
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
