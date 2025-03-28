$jdkArgs = @{
    version = '24'
    url64bit = 'https://github.com/adoptium/temurin24-binaries/releases/download/jdk-24%2B36/OpenJDK24U-jdk_x64_windows_hotspot_24_36.msi'
    checksum64bit = '168a9d9ead2f75de44f6d49ac35a58879066c1215375824ada6e6dc4a9ad0b95'
    url32bit = ''
    checksum32bit = ''
}
Install-RemalAdoptiumJdk @jdkArgs
