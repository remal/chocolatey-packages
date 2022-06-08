@echo off

setlocal

set FILE=%1
if "%FILE%" == "" goto usage
set MAX_LINES=%2
if "%MAX_LINES%" == "" goto usage
if %MAX_LINES% leq 0 goto usage


set /a LINES=0
for /f %%a in ('type "%FILE%"^|find "" /v /c') do set /a LINES=%%a
echo %FILE% has %LINES% lines

set /a LINES=LINES-MAX_LINES
if %LINES% leq 0 exit /b
more +%LINES% < %FILE% > %FILE%.%~nx0
copy /Y %FILE%.%~nx0 %FILE% > nul
del %FILE%.%~nx0

exit /b

:usage
echo Usage:
echo %~nx0 ^<file^> ^<max-lines-to-leave^>
exit /b
