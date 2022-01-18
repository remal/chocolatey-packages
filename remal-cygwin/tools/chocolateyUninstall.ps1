$cygwinPath = Get-EnvironmentVariable -Name 'CYGWIN_PATH' -Scope 'Machine'

Uninstall-ChocolateyEnvironmentVariable -VariableName 'CYGWIN_PATH' -VariableType 'Machine'
Uninstall-RemalPath -PathToUninstall "$cygwinPath\bin" -PathType 'Machine'
