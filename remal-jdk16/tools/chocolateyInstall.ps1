$jdkArgs = @{
    version = '16'
    url64bit = 'https://github.com/adoptium/temurin16-binaries/releases/download/jdk-16.0.2%2B7/OpenJDK16U-jdk_x64_windows_hotspot_16.0.2_7.msi'
    checksum64bit = 'b153c6ce102c6f05fd710c4b26c64224b649457613dad4830dcc6b551c0a4b3d'
    url32bit = 'https://github.com/adoptium/temurin16-binaries/releases/download/jdk-16.0.2%2B7/OpenJDK16U-jdk_x86-32_windows_hotspot_16.0.2_7.msi'
    checksum32bit = '5f988fe7360e769918831c0842f8aa4b3f71103b32cdb67ded57750fcb42ecdc'
}
Install-RemalAdoptiumJdk @jdkArgs
