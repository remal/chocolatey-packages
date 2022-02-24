@echo %CMDCMDLINE% | @find /i "/c" > nul
@if not ERRORLEVEL 1 @pause
