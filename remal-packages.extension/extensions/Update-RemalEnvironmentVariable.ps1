function Update-RemalEnvironmentVariable {
param(
  [parameter(Mandatory=$true, Position=0)][string] $variableName,
  [parameter(Mandatory=$false, Position=1)][string] $variableValue,
  [parameter(Mandatory=$false, Position=1)][System.EnvironmentVariableTarget] $variableType = [System.EnvironmentVariableTarget]::User,
  [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
)

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  if ($variableValue -ne $null -and $variableValue -ne '') {
    Install-ChocolateyEnvironmentVariable -variableName $variableName -variableValue $variableValue -variableType $variableType
  } else {
    Uninstall-ChocolateyEnvironmentVariable -variableName $variableName -variableType $variableType
  }

}
