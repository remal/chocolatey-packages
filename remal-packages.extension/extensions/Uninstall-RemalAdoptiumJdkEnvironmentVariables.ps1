function Uninstall-RemalAdoptiumJdkEnvironmentVariables {
param(
  [parameter(Mandatory=$true, Position=1)][string] $version,
  [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
)

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  $args = @{
    VariableName = 'JAVA_HOME_'+$version
    VariableType = 'Machine'
  }
  Uninstall-ChocolateyEnvironmentVariable @args

}
