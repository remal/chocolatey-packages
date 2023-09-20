$jdkArgs = @{
    version = '11'
    url64bit = 'https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.20.1%2B1/OpenJDK11U-jdk_x64_windows_hotspot_11.0.20.1_1.msi'
    checksum64bit = '51785957427c5f34581930fbb224a44550f70d1c5ecb6f05ab27432e6a1f9a75'
    url32bit = 'https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.20.1%2B1/OpenJDK11U-jdk_x86-32_windows_hotspot_11.0.20.1_1.msi'
    checksum32bit = '5f507a9bd3a2a79bda88a984c2c1d748e89e0485c915620ebb34d866e72d3538'
}
Install-RemalAdoptiumJdk @jdkArgs
