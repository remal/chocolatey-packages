function Uninstall-RemalAdoptiumJdkMainEnvironmentVariables {
param(
  [parameter(Mandatory=$true, Position=1)][string] $version,
  [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
)

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  $args = @{
    VariableName = 'JAVA_MAIN_VERSION'
    VariableType = 'Machine'
  }
  Uninstall-ChocolateyEnvironmentVariable @args

  $args = @{
    VariableName = 'JAVA_HOME'
    VariableType = 'Machine'
  }
  Uninstall-ChocolateyEnvironmentVariable @args

  $args = @{
    PathToUninstall = '%JAVA_HOME_'+$version+'%\bin'
    PathType = 'Machine'
  }
  Uninstall-RemalPath @args

  $javaHome = Get-EnvironmentVariable -Name ('JAVA_HOME_'+$version) -Scope 'Machine'
  $args = @{
    PathToUninstall = $javaHome + '\bin'
    PathType = 'Machine'
  }
  Uninstall-RemalPath @args

}
