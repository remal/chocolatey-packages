$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$assetsPath = "$toolsPath/assets"
[array]$files = Get-ChildItem $assetsPath -Recurse -Force | select -expand name

foreach ($file in $files) {
  if (("${env:HomeDrive}" -ne '') -and (Test-Path "${env:HomeDrive}/$file")) {
    Write-Host "Removing ${env:HomeDrive}/$file"
    Remove-Item -Path "${env:HomeDrive}/$file" -Force -Verbose:$VerbosePreference
  }

  if (("${env:SystemDrive}" -ne '') -and (Test-Path "${env:SystemDrive}/$file")) {
    Write-Host "Removing ${env:SystemDrive}/$file"
    Remove-Item -Path "${env:SystemDrive}/$file" -Force -Verbose:$VerbosePreference
  }
}
