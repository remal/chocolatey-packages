@echo %CMDCMDLINE% | @findstr /I /C:"\cmd.exe /c" >nul 2>&1
@if %ERRORLEVEL% == 0 pause
