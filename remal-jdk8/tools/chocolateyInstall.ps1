$jdkArgs = @{
    version = '8'
    url64bit = 'https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u382-b05/OpenJDK8U-jdk_x64_windows_hotspot_8u382b05.msi'
    checksum64bit = 'da10c23aa318764adc8361df0e0363fa50f885abe97b229fb0e4d4fe8c9f9679'
    url32bit = 'https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u382-b05/OpenJDK8U-jdk_x86-32_windows_hotspot_8u382b05.msi'
    checksum32bit = '64781e479765309fb4453510c9610ae845aa816889035d344c3fdb460ff74814'
}
Install-RemalAdoptiumJdk @jdkArgs
