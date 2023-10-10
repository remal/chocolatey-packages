$ErrorActionPreference = "Stop"


$identities = "BUILTIN\Users", "NT AUTHORITY\Authenticated Users"
foreach ($identity in $identities) {
    $acl = Get-Acl "${env:ProgramFiles}\nodejs"
    $acl.SetAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule($identity, "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")))
    Set-Acl "${env:ProgramFiles}\nodejs" $acl
}


& corepack enable


$yarnVersion = '3.6.4' # renovate: datasource=npm depName=@yarnpkg/cli
$tergetFile = "${env:LOCALAPPDATA}\node\corepack\yarn\${yarnVersion}\yarn.js"
$url = "https://repo.yarnpkg.com/${yarnVersion}/packages/yarnpkg-cli/bin/yarn.js"

$targetDir = [System.IO.Path]::GetDirectoryName($tergetFile)
if (!(Test-Path($targetDir))) {
    [System.IO.Directory]::CreateDirectory($targetDir) | Out-Null
}

Get-WebFile -FileName $tergetFile -Url $url

& corepack prepare "yarn@${yarnVersion}" --activate
