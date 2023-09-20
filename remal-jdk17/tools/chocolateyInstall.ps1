$jdkArgs = @{
    version = '17'
    url64bit = 'https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8.1%2B1/OpenJDK17U-jdk_x64_windows_hotspot_17.0.8.1_1.msi'
    checksum64bit = '430bc8e8f25d4d41b21ab9a8a0008db36b97f9f70863b300628a95e9692efcaa'
    url32bit = 'https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8.1%2B1/OpenJDK17U-jdk_x86-32_windows_hotspot_17.0.8.1_1.msi'
    checksum32bit = '250108a59338774b9e862f27f83fbf75d0bf155afea624e09f2b4fb5104fca7b'
}
Install-RemalAdoptiumJdk @jdkArgs
