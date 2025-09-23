$jdkArgs = @{
    version = '25'
    url64bit = 'https://github.com/adoptium/temurin25-binaries/releases/download/jdk-25%2B36/OpenJDK25U-jdk_x64_windows_hotspot_25_36.msi'
    checksum64bit = 'd899afd9c8160b8de9dcf2cced8da33702e00104068eac50e33dd1cbf1df5248'
    url32bit = ''
    checksum32bit = ''
}
Install-RemalAdoptiumJdk @jdkArgs
