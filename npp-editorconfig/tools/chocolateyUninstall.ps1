$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

# @TODO: query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Notepad++ to find installation path

$registryInstallationPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Notepad++"
$portableInstallationPath = "${env:AllUsersProfile}\chocolatey\lib\notepadplusplus.commandline\tools"
if (Test-Path $registryInstallationPath){
  $NotepadPlusPlusApplicationPath = Split-Path -Parent -Path (
    Get-ItemProperty -Path $registryInstallationPath
  ).DisplayIcon
}
elseif (Test-Path $portableInstallationPath){
  $NotepadPlusPlusApplicationPath = $portableInstallationPath
}

$NotepadPlusPlusProcessName = 'Notepad++'

if ( Test-Path -Path $NotepadPlusPlusApplicationPath ){
  Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Warning "Closing running instances of Notepad++, please save your files"
    $_.CloseMainWindow() | Out-Null
  }
  Start-Sleep -Milliseconds 500
  if ($VerbosePreference){
    Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue
  }
  Remove-Item -Path "${NotepadPlusPlusApplicationPath}/plugins/NppEditorConfig" -Recurse -Force -Confirm:$False -Verbose:$VerbosePreference
} else {
  throw "Cannot find installation of Notepad++"
}
