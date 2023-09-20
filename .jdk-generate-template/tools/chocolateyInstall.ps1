$jdkArgs = @{
    version = '#MAJOR_VERSION#'
    url64bit = '#URL_64#'
    checksum64bit = '#URL_64_CHECKSUM#'
    url32bit = '#URL_32#'
    checksum32bit = '#URL_32_CHECKSUM#'
}
Install-RemalAdoptiumJdk @jdkArgs
