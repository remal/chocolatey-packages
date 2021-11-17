function Install-RemalAdoptiumJdkMain {
param(
  [parameter(Mandatory=$true, Position=1)][string] $version,
  [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
)

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  $currentJavaMainVersion = Get-EnvironmentVariable -Name 'JAVA_MAIN_VERSION' -Scope 'Machine'
  if ($currentJavaMainVersion -eq $null -or $currentJavaMainVersion -eq '') {
    # do nothing
  } elseif ($currentJavaMainVersion -ne $version) {
    throw "Another JDK version is used as main - $($currentJavaMainVersion), uninstall 'remal-jdk$($currentJavaMainVersion)-main' package first"
  }

  $args = @{
    VariableName = 'JAVA_MAIN_VERSION'
    VariableValue = $version
    VariableType = 'Machine'
  }
  Install-ChocolateyEnvironmentVariable @args

  $javaHome = Get-EnvironmentVariable -Name ('JAVA_HOME_'+$version) -Scope 'Machine'
  Write-Host "Setting JAVA_HOME to $javaHome"
  $args = @{
    VariableName = 'JAVA_HOME'
    VariableValue = $javaHome
    VariableType = 'Machine'
  }
  Install-ChocolateyEnvironmentVariable @args

  $args = @{
    PathToInstall = $javaHome + '\bin'
    PathType = 'Machine'
  }
  Install-RemalPath @args

}
