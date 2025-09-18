$identities = "BUILTIN\Users", "NT AUTHORITY\Authenticated Users"
foreach ($identity in $identities) {
    $acl = Get-Acl "${env:ProgramFiles}\nodejs"
    $acl.SetAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule($identity, "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")))
    Set-Acl "${env:ProgramFiles}\nodejs" $acl
}


& corepack enable
if ($? -eq $false) { throw "<Error Exit>" }


# $yarnVersion = '4.10.1' # renovate: datasource=npm depName=@yarnpkg/cli

# $targetDir = "${env:LOCALAPPDATA}\node\corepack\yarn\${yarnVersion}"
# $targetFile = "${targetDir}\yarn.js"
# $url = "https://repo.yarnpkg.com/${yarnVersion}/packages/yarnpkg-cli/bin/yarn.js"
# Get-WebFile -FileName $targetFile -Url $url

# & corepack install --global "yarn@${yarnVersion}"
# if ($? -eq $false) { throw "<Error Exit>" }
