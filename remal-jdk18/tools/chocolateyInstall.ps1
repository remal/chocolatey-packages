$jdkArgs = @{
    version = '18'
    url64bit = 'https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18.0.2.1%2B1/OpenJDK18U-jdk_x64_windows_hotspot_18.0.2.1_1.msi'
    checksum64bit = 'e766c2d6100e70786ff0bb154054dd64bb45ea14ffc995544bbced98eb1c8703'
    url32bit = 'https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18.0.2.1%2B1/OpenJDK18U-jdk_x86-32_windows_hotspot_18.0.2.1_1.msi'
    checksum32bit = '42c8472b2806210ac021212ec6c2115476a0a0444d5910b35d077e854f1aed13'
}
Install-RemalAdoptiumJdk @jdkArgs
