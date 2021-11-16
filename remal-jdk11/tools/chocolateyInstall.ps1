$jdkArgs = @{
  version = '11'
  url64bit = 'https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.13%2B8/OpenJDK11U-jdk_x64_windows_hotspot_11.0.13_8.msi'
  checksum64bit = 'B0EDEA638FD58C94D80ABFFD10BBB27731BF6FE1E2B3A9214FB68AB18237DEED'
  url32bit = 'https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.13%2B8/OpenJDK11U-jdk_x86-32_windows_hotspot_11.0.13_8.msi'
  checksum32bit = '52C3DE8EB38CD559091BC07D264A27E6BA28DF0067443E30C15511FE4AE70679'
}

Install-RemalAdoptiumJdk @jdkArgs
