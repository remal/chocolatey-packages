@echo off
setlocal enableDelayedExpansion

set PACKAGE=%~1
if "!PACKAGE!" == "" (
    echo ::error::Package name is not set or empty 1>&2
    exit /B 1
)

echo choco pack "%~dp0\!PACKAGE!\!PACKAGE!.nuspec" --outputdirectory "%~dp0\.packed"
choco pack "%~dp0\!PACKAGE!\!PACKAGE!.nuspec" --outputdirectory "%~dp0\.packed" || exit /B !ERRORLEVEL!
