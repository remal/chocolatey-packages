$jdkArgs = @{
    version = '21'
    url64bit = 'https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.2%2B13/OpenJDK21U-jdk_x64_windows_hotspot_21.0.2_13.msi'
    checksum64bit = 'd0c53b1bfa741b7f6484200faf8452e5a779357c2a29aa6b0dfdedf7173e903f'
    url32bit = ''
    checksum32bit = ''
}
Install-RemalAdoptiumJdk @jdkArgs
