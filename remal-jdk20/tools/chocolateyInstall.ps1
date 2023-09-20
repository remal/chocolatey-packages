$jdkArgs = @{
    version = '20'
    url64bit = 'https://github.com/adoptium/temurin20-binaries/releases/download/jdk-20.0.2%2B9/OpenJDK20U-jdk_x64_windows_hotspot_20.0.2_9.msi'
    checksum64bit = '703be6194d2ae3fc90870497417e22a72ba9a65995aa84b63bca4f4e1fb8395a'
    url32bit = ''
    checksum32bit = ''
}
Install-RemalAdoptiumJdk @jdkArgs
