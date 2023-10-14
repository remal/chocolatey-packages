$jdkArgs = @{
    version = '21'
    url64bit = 'https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21%2B35/OpenJDK21U-jdk_x64_windows_hotspot_21_35.msi'
    checksum64bit = '420b09998ae215154b6665c4d8167a74fd99eb3d4d85d5657ba317666e65e301'
    url32bit = ''
    checksum32bit = ''
}
Install-RemalAdoptiumJdk @jdkArgs
