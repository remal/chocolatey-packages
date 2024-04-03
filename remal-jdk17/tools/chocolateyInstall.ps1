$jdkArgs = @{
    version = '17'
    url64bit = 'https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.10%2B7/OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.msi'
    checksum64bit = 'd45b610b1800e35fd667d144277272e3323c7fafa21c0312649fc60a86913a3d'
    url32bit = 'https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.10%2B7/OpenJDK17U-jdk_x86-32_windows_hotspot_17.0.10_7.msi'
    checksum32bit = 'f30b0dcd1b0f95e6ccca712fe1cbe0f8ba577ae5ccef28b08a1c77c7209fdc7c'
}
Install-RemalAdoptiumJdk @jdkArgs
