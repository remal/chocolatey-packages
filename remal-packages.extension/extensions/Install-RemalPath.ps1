function Install-RemalPath {
param(
  [parameter(Mandatory=$true, Position=1)][string] $pathToInstall,
  [parameter(Mandatory=$false, Position=1)][System.EnvironmentVariableTarget] $pathType = [System.EnvironmentVariableTarget]::User,
  [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
)

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  Uninstall-RemalPath -pathToUninstall $pathToInstall -pathType $pathType

  $actualPath = Get-EnvironmentVariable -Name 'PATH' -Scope $pathType -PreserveVariables
  $actualPath = $pathToInstall + ';' + $actualPath
  Install-ChocolateyEnvironmentVariable -variableName 'PATH' -variableValue $actualPath -variableType $pathType

  $envPSPath = $env:PATH
  $env:Path = $actualPath

}
