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
$assetsToCopy = 'plugins'

$packageArgs = @{
  PackageName = 'npp-editorconfig'
  UnzipLocation = "${toolsPath}/plugins/NppEditorConfig"
  Url64bit = 'https://github.com/editorconfig/editorconfig-notepad-plus-plus/releases/download/v0.4.0/NppEditorConfig-040-x64.zip'
  Checksum64 = 'AE43152E91D8310AB28859992D3661ABA24D8D69A64B93CD12B2F531A1038F56'
  ChecksumType64 = 'sha256'
  Url = 'https://github.com/editorconfig/editorconfig-notepad-plus-plus/releases/download/v0.4.0/NppEditorConfig-040-x86.zip'
  Checksum = 'D5E76E32DD8A06C4B9E3C2C057CA0849CEE466C2E608C0AD04907F68698DB850'
  ChecksumType = 'sha256'
  SoftwareName = 'npp-editorconfig*'
}
Install-ChocolateyZipPackage @packageArgs

if ( Test-Path -Path $NotepadPlusPlusApplicationPath ){
  Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Warning "Closing running instances of Notepad++, please save your files"
    $_.CloseMainWindow() | Out-Null
  }
  Start-Sleep -Milliseconds 500
  if ($VerbosePreference){
    Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue
  }
  Copy-Item -Path $toolsPath/* -Include $assetsToCopy -Destination $NotepadPlusPlusApplicationPath -Force -Recurse -Confirm:$False -Verbose:$VerbosePreference
} else {
  throw "Cannot find installation of Notepad++"
}
