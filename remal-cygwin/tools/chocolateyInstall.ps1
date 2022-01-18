$cygwinPath = (Get-ItemProperty 'HKLM:\SOFTWARE\Cygwin\setup' -ea 0).rootdir
if (!$cygwinPath) {
  $toolsPath = Get-ToolsLocatio
  $cygwinPath = "$toolsPath\cygwin"
}
if (!(Test-Path $cygwinPath)) {
  throw "Cannot find installation dir of Cygwin"
}

Install-ChocolateyEnvironmentVariable -VariableName 'CYGWIN_PATH' -VariableValue $cygwinPath -VariableType 'Machine'
Install-RemalPath -PathToInstall "$cygwinPath\bin" -PathType 'Machine'
