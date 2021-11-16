$jdkArgs = @{
  version = '17'
  url64bit = 'https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_x64_windows_hotspot_17.0.1_12.msi'
  checksum64bit = 'F5241BB43B589E45B6C3133FAE6CC8CBFFEC4CAE2504C3B99C3FAC0C50CBF11E'
  url32bit = 'https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_x86-32_windows_hotspot_17.0.1_12.msi'
  checksum32bit = 'EEAA82A79AE7A488EFE152DF121F11AB9D2B9554DEB2AFE8B4A4110297205367'
}

Install-RemalAdoptiumJdk @jdkArgs
