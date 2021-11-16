@echo off
setlocal enableDelayedExpansion

for /F "tokens=*" %%G in ('dir *.nuspec /A-D /S /B') do (
    echo Processing %%G
    choco pack "%%G" --outputdirectory "%~dp0\.packed"
)
