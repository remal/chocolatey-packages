function Uninstall-RemalPath {
param(
  [parameter(Mandatory=$true, Position=1)][string] $pathToUninstall,
  [parameter(Mandatory=$false, Position=1)][System.EnvironmentVariableTarget] $pathType = [System.EnvironmentVariableTarget]::User,
  [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
)

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  $actualPath = Get-EnvironmentVariable -Name 'PATH' -Scope $pathType -PreserveVariables
  $currentPath = $actualPath
  $actualPath = ';' + $actualPath + ';'

  while ($true) {
    $pos = $actualPath.ToLower().IndexOf(';' + $pathToUninstall.ToLower() + ';')
    if ($pos -ge 0) {
      $actualPath = $actualPath.substring(0, $pos) + $actualPath.substring($pos + $pathToUninstall.length + 1)
    } else {
      break
    }
  }

  while ($true) {
    if ($actualPath -eq '') {
      break
    } elseif ($actualPath.substring(0, 1) -eq ';') {
      $actualPath = $actualPath.substring(1)
    } elseif ($actualPath.substring($actualPath.length - 1) -eq ';') {
      $actualPath = $actualPath.substring(0, $actualPath.length - 1)
    } else {
      break
    }
  }

  if ($currentPath -ne $actualPath) {
    Install-ChocolateyEnvironmentVariable -variableName 'PATH' -variableValue $actualPath -variableType $pathType

    $envPSPath = $env:PATH
    $env:Path = $actualPath
  }

}
