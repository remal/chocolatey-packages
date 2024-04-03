$jdkArgs = @{
    version = '22'
    url64bit = 'https://github.com/adoptium/temurin22-binaries/releases/download/jdk-22%2B36/OpenJDK22U-jdk_x64_windows_hotspot_22_36.msi'
    checksum64bit = 'a825f7098a99a6e6a6dca621ba58a60ec285eee19a27e641870ff7cdfd223a85'
    url32bit = ''
    checksum32bit = ''
}
Install-RemalAdoptiumJdk @jdkArgs
