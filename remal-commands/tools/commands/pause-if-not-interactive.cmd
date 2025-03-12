@echo %CMDCMDLINE% | @findstr /I /C:"\cmd.exe /c" >nul 2>&1
@if %errorlevel% == 0 pause
