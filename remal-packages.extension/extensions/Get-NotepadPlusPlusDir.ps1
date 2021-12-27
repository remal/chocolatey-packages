function Get-NotepadPlusPlusDir {
param(
  [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
)

  Write-FunctionCallLogMessage -Invocation $MyInvocation -Parameters $PSBoundParameters

  $registryInstallationPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Notepad++"
  if (Test-Path $registryInstallationPath) {
    $dir = Split-Path -Parent -Path (
      Get-ItemProperty -Path $registryInstallationPath
    ).DisplayIcon
    if (Test-Path "$dir\notepad++.exe") {
      return $dir
    }
  }

  if ("${env:ProgramFiles}" -ne '') {
    $programFilesInstallationPath = "${env:ProgramFiles}\Notepad++"
    if (Test-Path "$programFilesInstallationPath\notepad++.exe") {
      return $programFilesInstallationPath
    }
  }

  if ("${env:ProgramFiles(x86)}" -ne '') {
    $programFiles86InstallationPath = "${env:ProgramFiles(x86)}\Notepad++"
    if (Test-Path "$programFiles86InstallationPath\notepad++.exe") {
      return $programFiles86InstallationPath
    }
  }

  if ("${env:AllUsersProfile}" -ne '') {
    $portableInstallationPath = "${env:AllUsersProfile}\chocolatey\lib\notepadplusplus.commandline\tools"
    if (Test-Path "$portableInstallationPath\notepad++.exe") {
      return $portableInstallationPath
    }
  }

  throw "Cannot find installation dir of Notepad++"

}
