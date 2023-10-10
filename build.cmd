@echo off
setlocal enableDelayedExpansion

set PACKAGE=%~1
if "!PACKAGE!" == "" (
    echo ::error::Package name is not set or empty 1>&2
    exit /B 1
)

set PUBLISH=%~2

set REPOSITORY=%CHOCO_REMAL_PACKAGES_REPOSITORY%
if "!REPOSITORY!" == "" (
    echo ::error::Repository URL is not set or empty 1>&2
    exit /B 1
)

rem ===========================================================================

if exist "%~dp0\!PACKAGE!\.do-not-build" (
    echo Skip building !PACKAGE! because of .do-not-build marker
    exit /B 0
)

rem ===========================================================================

if exist "%~dp0\!PACKAGE!\test-prerequisites.cmd" (
    echo.

    echo Testing prerequisites
    call "%~dp0\!PACKAGE!\test-prerequisites.cmd"
    if !ERRORLEVEL! NEQ 0 (
        echo ::error::Prerequisites tests failed with error level !ERRORLEVEL! 1>&2
        exit /B !ERRORLEVEL!
    )

    echo.
)

rem ===========================================================================

set TARGET_DIR=%TEMP%\!PACKAGE!
rd /S /Q "!TARGET_DIR!" 2>nul
mkdir "!TARGET_DIR!"

rem ===========================================================================

echo.

echo Packing !PACKAGE!
echo choco pack "!PACKAGE!\!PACKAGE!.nuspec" --outputdirectory "!TARGET_DIR!"
choco pack "!PACKAGE!\!PACKAGE!.nuspec" --outputdirectory "!TARGET_DIR!"
if !ERRORLEVEL! NEQ 0 (
    echo ::error::Command execution failed: choco pack 1>&2
    exit /B !ERRORLEVEL!
)

dir "!TARGET_DIR!"

echo.

rem ===========================================================================

if exist "%~dp0\!PACKAGE!\.do-not-test" (
    echo Skip testing !PACKAGE! because of .do-not-build marker
) else (
    echo.

    echo Testing !PACKAGE!

    if "%CI%" == "true" (
        echo Executing Chocolatey tests on CI
    ) else (
        set /P AREYOUSURE="Executing Chocolatey tests on local machine. Are you sure (Y/[N])?"
        if /I "!AREYOUSURE!" NEQ "Y" exit /B 0
    )

    choco source remove -n="test-!PACKAGE!-local" 2>nul
    choco source add -n="test-!PACKAGE!-local" -s="!TARGET_DIR!" || exit /B !ERRORLEVEL!
    choco source remove -n="test-!PACKAGE!-repo" 2>nul
    choco source add -n="test-!PACKAGE!-repo" -s="!REPOSITORY!" || exit /B !ERRORLEVEL!

    set INSTALL_LOGGING=
    set INSTALL_LOGGING=--trace

    echo choco install "!PACKAGE!" --force %INSTALL_LOGGING%
    choco install "!PACKAGE!" --force %INSTALL_LOGGING%
    if !ERRORLEVEL! NEQ 0 (
        set LAST_ERRORLEVEL=!ERRORLEVEL!
        echo ::error::Command execution failed: choco install 1>&2
        choco source remove "-n=test-!PACKAGE!-local" 2>nul
        choco source remove "-n=test-!PACKAGE!-repo" 2>nul
        exit /B !LAST_ERRORLEVEL!
    )

    echo choco uninstall "!PACKAGE!" --force %INSTALL_LOGGING%
    choco uninstall "!PACKAGE!" --force %INSTALL_LOGGING%
    if !ERRORLEVEL! NEQ 0 (
        set LAST_ERRORLEVEL=!ERRORLEVEL!
        echo ::error::Command execution failed: choco uninstall 1>&2
        choco source remove "-n=test-!PACKAGE!-local" 2>nul
        choco source remove "-n=test-!PACKAGE!-repo" 2>nul
        exit /B !LAST_ERRORLEVEL!
    )

    choco source remove "-n=test-!PACKAGE!-local" 2>nul
    choco source remove "-n=test-!PACKAGE!-repo" 2>nul

    echo.
)

rem ===========================================================================

if exist "%~dp0\!PACKAGE!\.do-not-publish" (
    echo Skip pulishing !PACKAGE! because of .do-not-publish marker
    exit /B 0
)

rem ===========================================================================

echo.

if /I "!PUBLISH!" NEQ "Y" (
    echo Skip pulishing !PACKAGE!

) else (
    set REPOSITORY_TOKEN=%~3
    if "!REPOSITORY_TOKEN!" == "" (
        echo ::error::Repository token is not set or empty 1>&2
        exit /B 1
    )

    echo Pushing !PACKAGE!
    pushd "!TARGET_DIR!"
    echo choco push -source "!REPOSITORY!" --apikey "!REPOSITORY_TOKEN!"
    choco push -source "!REPOSITORY!" --apikey "!REPOSITORY_TOKEN!"
    if !ERRORLEVEL! NEQ 0 (
        echo ::error::Command execution failed: choco push 1>&2
        popd
        exit /B !ERRORLEVEL!
    )
    popd

    del ".packed\%PACKAGE%.*.nupkg.bak" >nul 2>nul
    for /F "tokens=*" %%F in ('dir ".packed\%PACKAGE%.*.nupkg" /A-D /B') do (
        ren ".packed\%%F" "%%~nxF.bak"
    )

    copy /Y "!TARGET_DIR!" .packed

    git rev-parse HEAD > .last-publish.commit
)
