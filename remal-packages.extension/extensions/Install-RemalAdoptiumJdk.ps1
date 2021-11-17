function Install-RemalAdoptiumJdk {
param(
  [parameter(Mandatory=$true, Position=1)][string] $version,
  [parameter(Mandatory=$true, Position=2)][string] $url64bit,
  [parameter(Mandatory=$true, Position=3)][string] $checksum64bit,
  [parameter(Mandatory=$true, Position=4)][string] $url32bit,
  [parameter(Mandatory=$true, Position=5)][string] $checksum32bit,
  [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
)

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  $prevJavaHome = Get-EnvironmentVariable -Name 'JAVA_HOME' -Scope 'Machine' -PreserveVariables

  $args = @{
    PackageName = $env:ChocolateyPackageName
    Url64bit = $url64bit
    Checksum64 = $checksum64bit
    ChecksumType64 = 'sha256'
    Url = $url32bit
    Checksum = $checksum32bit
    ChecksumType = 'sha256'
    fileType = 'msi'
    silentArgs = 'INSTALLLEVEL=3 /quiet INSTALLDIR="C:\\Program Files\\Java\\jdk-'+$version+'" REBOOT=0 NOSTARTMENU=1 AUTO_UPDATE=0 WEB_ANALYTICS=0 WEB_JAVA=0 SPONSORS=0'
  }
  Install-ChocolateyPackage @args

  $args = @{
    VariableName = 'JAVA_HOME_'+$version
    VariableValue = 'C:\Program Files\Java\jdk-'+$version
    VariableType = 'Machine'
  }
  Install-ChocolateyEnvironmentVariable @args

  $args = @{
    VariableName = 'JAVA_HOME'
    VariableValue = $prevJavaHome
    VariableType = 'Machine'
  }
  Update-RemalEnvironmentVariable @args

  $args = @{
    PathToUninstall = 'C:\Program Files\Java\jdk-'+$version+'\bin'
    PathType = 'Machine'
  }
  Uninstall-RemalPath @args

  $args = @{
    PathToUninstall = 'C:\Program Files\Java\jdk-'+$version+'\bin\'
    PathType = 'Machine'
  }
  Uninstall-RemalPath @args

}
