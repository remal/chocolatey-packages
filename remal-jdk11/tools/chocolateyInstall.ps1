$jdkArgs = @{
    version = '11'
    url64bit = 'https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.22%2B7/OpenJDK11U-jdk_x64_windows_hotspot_11.0.22_7.msi'
    checksum64bit = 'a628fdaf29923f4cc2dfd3445369a4c1ce9c205bdf219a8ac33f809d489ffb6f'
    url32bit = 'https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.22%2B7/OpenJDK11U-jdk_x86-32_windows_hotspot_11.0.22_7.msi'
    checksum32bit = 'd881a1c8fed4483133496fdd64e4531e5e913ef7e8d67eb3a468a333150ead6e'
}
Install-RemalAdoptiumJdk @jdkArgs
