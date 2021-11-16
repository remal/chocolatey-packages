function Uninstall-RemalPath {
param(
  [parameter(Mandatory=$true, Position=1)][string] $pathToUninstall,
  [parameter(Mandatory=$false, Position=1)][System.EnvironmentVariableTarget] $pathType = [System.EnvironmentVariableTarget]::User,
  [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
)

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  $actualPath = Get-EnvironmentVariable -Name 'Path' -Scope $pathType -PreserveVariables
  if ($actualPath.ToLower().StartsWith($pathToUninstall.ToLower() + ';')) {
    $actualPath = $actualPath.substring($pathToUninstall.length + 1)
    Install-ChocolateyEnvironmentVariable -variableName 'Path' -variableValue $actualPath -variableType $pathType

  } elseif ($actualPath.ToLower().EndsWith(';' + $pathToUninstall.ToLower())) {
    $actualPath = $actualPath.substring($actualPath.length - $pathToUninstall.length - 1)
    Install-ChocolateyEnvironmentVariable -variableName 'Path' -variableValue $actualPath -variableType $pathType

  } elseif ($actualPath.ToLower().Contains(';' + $pathToUninstall.ToLower() + ';')) {
    $actualPath = $actualPath.Replace(';' + $pathToUninstall.ToLower() + ';', ';')
    Install-ChocolateyEnvironmentVariable -variableName 'Path' -variableValue $actualPath -variableType $pathType
  }

}
