@echo on
@setlocal enableDelayedExpansion

@set PACKAGE=%~1

choco pack "%PACKAGE%\%PACKAGE%.nuspec" --outputdirectory "%~dp0\.packed"
@if %ERRORLEVEL% NEQ 0 (
  echo "choco pack command execution failed."
  exit %ERRORLEVEL%
)
