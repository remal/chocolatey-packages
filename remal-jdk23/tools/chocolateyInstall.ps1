$jdkArgs = @{
    version = '23'
    url64bit = 'https://github.com/adoptium/temurin23-binaries/releases/download/jdk-23%2B37/OpenJDK23U-jdk_x64_windows_hotspot_23_37.msi'
    checksum64bit = '39b7594580597ab85b3b4769d945e70d1665b3b8167c70039db407d2fb36803f'
    url32bit = ''
    checksum32bit = ''
}
Install-RemalAdoptiumJdk @jdkArgs
