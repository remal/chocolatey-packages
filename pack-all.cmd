@echo off
setlocal enableDelayedExpansion

for /F "tokens=*" %%D in ('dir /AD /B') do (
    if exist "%%D\%%D.nuspec" (
        call "%~dp0\pack" "%%D" || exit /B !ERRORLEVEL!
    )
)
