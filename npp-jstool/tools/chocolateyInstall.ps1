$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'


$bitWidth = 32
if (Get-ProcessorBits 64) {
  $forceX86 = $env:chocolateyForceX86
  if ($forceX86) {
    # do nothing
  } else {
    $bitWidth = 64
  }
}

$archivePath = "${toolsPath}/archives/JSToolNPP.1.2107.2.uni.${bitWidth}.zip"
$unzipLocation = "${toolsPath}/plugins/JSMinNPP"
Get-ChocolateyUnzip "$archivePath" $unzipLocation '' 'npp-jstool'

Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue | ForEach-Object {
  Write-Warning "Closing running instances of Notepad++, please save your files"
  $_.CloseMainWindow() | Out-Null
}
Start-Sleep -Milliseconds 500
if ($VerbosePreference){
  Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue
}
Copy-Item -Path $toolsPath/* -Include $assetsToCopy -Destination $NotepadPlusPlusApplicationPath -Force -Recurse -Confirm:$False -Verbose:$VerbosePreference
