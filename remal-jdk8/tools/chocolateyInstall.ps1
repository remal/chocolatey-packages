$jdkArgs = @{
  version = '8'
  url64bit = 'https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u312-b07/OpenJDK8U-jdk_x64_windows_hotspot_8u312b07.msi'
  checksum64bit = '5544EBCB03206F3C3F5F19F6DA03003A154CB2B489A06D88A052792F72B76C21'
  url32bit = 'https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u312-b07/OpenJDK8U-jdk_x86-32_windows_hotspot_8u312b07.msi'
  checksum32bit = 'BD19EC2D8194477FD5B473E4DC9244E800E7CBBEC03883481B0DB49E1EAC520B'
}

Install-RemalAdoptiumJdk @jdkArgs
