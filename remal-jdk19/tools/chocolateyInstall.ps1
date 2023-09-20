$jdkArgs = @{
    version = '19'
    url64bit = 'https://github.com/adoptium/temurin19-binaries/releases/download/jdk-19.0.2%2B7/OpenJDK19U-jdk_x64_windows_hotspot_19.0.2_7.msi'
    checksum64bit = 'b2372bd728a5a708a4ce5ec6cc8b46489e5292051f4993568ec1d5f395f7e06e'
    url32bit = 'https://github.com/adoptium/temurin19-binaries/releases/download/jdk-19.0.2%2B7/OpenJDK19U-jdk_x86-32_windows_hotspot_19.0.2_7.msi'
    checksum32bit = '3663195c70afa2b05c8f0297bbf131b02f109159cf9e537afa8f5c7acc1294e7'
}
Install-RemalAdoptiumJdk @jdkArgs
