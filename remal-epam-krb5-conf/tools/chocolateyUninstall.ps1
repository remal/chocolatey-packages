$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$assetsPath = "$toolsPath/assets"
[array]$files = Get-ChildItem $assetsPath -Recurse -Force | select -expand name

foreach ($file in $files) {
  if (("${env:WINDIR}" -ne '') -and (Test-Path "${env:WINDIR}/$file")) {
    Write-Host "Removing ${env:WINDIR}/$file"
    Remove-Item -Path "${env:WINDIR}/$file" -Force -Verbose:$VerbosePreference
  }

  if (("${env:SYSTEMROOT}" -ne '') -and (Test-Path "${env:SYSTEMROOT}/$file")) {
    Write-Host "Removing ${env:SYSTEMROOT}/$file"
    Remove-Item -Path "${env:SYSTEMROOT}/$file" -Force -Verbose:$VerbosePreference
  }
}
