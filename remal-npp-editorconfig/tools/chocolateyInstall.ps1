$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$NotepadPlusPlusApplicationPath = Get-NotepadPlusPlusDir
$NotepadPlusPlusProcessName = 'Notepad++'
$assetsToCopy = 'plugins'

$packageArgs = @{
    PackageName = 'remal-npp-editorconfig'
    UnzipLocation = "${toolsPath}/plugins/NppEditorConfig"
    Url64bit = 'https://github.com/editorconfig/editorconfig-notepad-plus-plus/releases/download/v0.4.0/NppEditorConfig-040-x64.zip'
    Checksum64 = 'ae43152e91d8310ab28859992d3661aba24d8d69a64b93cd12b2f531a1038f56'
    ChecksumType64 = 'sha256'
    Url = 'https://github.com/editorconfig/editorconfig-notepad-plus-plus/releases/download/v0.4.0/NppEditorConfig-040-x86.zip'
    Checksum = 'd5e76e32dd8a06c4b9e3c2c057ca0849cee466c2e608c0ad04907f68698db850'
    ChecksumType = 'sha256'
    SoftwareName = 'remal-npp-editorconfig*'
}
Install-ChocolateyZipPackage @packageArgs

Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Warning "Closing running instances of Notepad++, please save your files"
    $_.CloseMainWindow() | Out-Null
}
Start-Sleep -Milliseconds 500
if ($VerbosePreference){
    Get-Process -Name $NotepadPlusPlusProcessName -ErrorAction SilentlyContinue
}
Copy-Item -Path $toolsPath/* -Include $assetsToCopy -Destination $NotepadPlusPlusApplicationPath -Force -Recurse -Confirm:$False -Verbose:$VerbosePreference
