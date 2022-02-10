$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$assetsPath = "$toolsPath/assets"

if ("${env:WINDIR}" -ne '') {
  Copy-Item -Path "$assetsPath/*" -Destination "${env:WINDIR}/" -Force -Recurse -Verbose:$VerbosePreference
}

if ("${env:SYSTEMROOT}" -ne '') {
  Copy-Item -Path "$assetsPath/*" -Destination "${env:SYSTEMROOT}/" -Force -Recurse -Verbose:$VerbosePreference
}
