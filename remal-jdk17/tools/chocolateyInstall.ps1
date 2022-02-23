$jdkArgs = @{
  version = '17'
  url64bit = 'https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.2%2B8/OpenJDK17U-jdk_x64_windows_hotspot_17.0.2_8.msi'
  checksum64bit = 'F66F21F0B25E4FE0449C41555DBEB7BA890D54E5A6E48E35B1A6309409EAF2D1'
}

Install-RemalAdoptiumJdk @jdkArgs
