$ErrorActionPreference = "Stop"


$identities = "BUILTIN\Users", "NT AUTHORITY\Authenticated Users"
foreach ($identity in $identities) {
    $acl = Get-Acl "${env:ProgramFiles}\nodejs"
    $acl.SetAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule($identity, "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")))
    Set-Acl "${env:ProgramFiles}\nodejs" $acl
}


& corepack enable
if ($? -eq $false) { throw "<Error Exit>" }


$yarnVersion = '3.6.4' # renovate: datasource=npm depName=@yarnpkg/cli
$targetFile = "${env:LOCALAPPDATA}\node\corepack\yarn\${yarnVersion}\yarn.js"
$url = "https://repo.yarnpkg.com/${yarnVersion}/packages/yarnpkg-cli/bin/yarn.js"
Get-WebFile -FileName $targetFile -Url $url

& corepack prepare "yarn@${yarnVersion}" --activate
if ($? -eq $false) { throw "<Error Exit>" }
