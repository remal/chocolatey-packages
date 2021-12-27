$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$assetsPath = "$toolsPath/assets"

if ("${env:HomeDrive}" -ne '') {
  Copy-Item -Path "$assetsPath/*" -Destination "${env:HomeDrive}/" -Force -Recurse -Verbose:$VerbosePreference
}

if ("${env:SystemDrive}" -ne '') {
  Copy-Item -Path "$assetsPath/*" -Destination "${env:SystemDrive}/" -Force -Recurse -Verbose:$VerbosePreference
}
