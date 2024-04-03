$jdkArgs = @{
    version = '8'
    url64bit = 'https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u402-b06/OpenJDK8U-jdk_x64_windows_hotspot_8u402b06.msi'
    checksum64bit = 'ddfbd420322c634e8524720846f6b1eb02435cc77875e2d3af1ac3398784c797'
    url32bit = 'https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u402-b06/OpenJDK8U-jdk_x86-32_windows_hotspot_8u402b06.msi'
    checksum32bit = '90f4d05a777d982d666f6321480cef1f72ba50298bc8872535e9e622dec8ba84'
}
Install-RemalAdoptiumJdk @jdkArgs
