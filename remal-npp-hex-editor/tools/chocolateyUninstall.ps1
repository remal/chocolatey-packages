$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'

Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue | ForEach-Object {
  Write-Warning "Closing running instances of Notepad++, please save your files"
  $_.CloseMainWindow() | Out-Null
}
Start-Sleep -Milliseconds 500
if ($VerbosePreference){
  Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue
}
Remove-Item -Path "${NotepadPlusPlusApplicationPath}/plugins/HexEditor" -Recurse -Force -Confirm:$False -Verbose:$VerbosePreference
