$identities = "BUILTIN\Users", "NT AUTHORITY\Authenticated Users"
foreach ($identity in $identities) {
    $acl = Get-Acl "${env:ProgramFiles}\nodejs"
    $acl.SetAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule($identity, "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")))
    Set-Acl "${env:ProgramFiles}\nodejs" $acl
}


& corepack enable


$yarnVersion = '3.6.4' # renovate: datasource=npm depName=@yarnpkg/cli
Get-WebFile -FileName "${env:LOCALAPPDATA}\node\corepack\yarn\${yarnVersion}\yarn.js" -Url "https://repo.yarnpkg.com/${yarnVersion}/packages/yarnpkg-cli/bin/yarn.js"

& corepack prepare "yarn@${yarnVersion}" --activate
