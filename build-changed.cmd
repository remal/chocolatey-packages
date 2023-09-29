@echo off
setlocal enableDelayedExpansion

if not exist changed-packages.tmp.txt (
    echo ::error::File doesn't exist: changed-packages.tmp.txt 1>&2
    exit /B 1
)

set SUMMARY_ERRORLEVEL=0
for /F "tokens=*" %%P in (changed-packages.tmp.txt) do (
    if exist "%~dp0\%%P\%%P.nuspec" (
        echo ::group::%%P

        echo call "%~dp0\build" "%%P" %*
        call "%~dp0\build" "%%P" %*

        set LAST_ERRORLEVEL=!ERRORLEVEL!
        if !LAST_ERRORLEVEL! NEQ 0 (
            echo ::error::Command execution failed: build 1>&2
            set SUMMARY_ERRORLEVEL=!LAST_ERRORLEVEL!
        )

        echo ::endgroup::

        if !LAST_ERRORLEVEL! NEQ 0 (
            echo ::error::Buiding %%P failed 1>&2
        )
    )
)

if !SUMMARY_ERRORLEVEL! NEQ 0 (
    exit /B !SUMMARY_ERRORLEVEL!
)
