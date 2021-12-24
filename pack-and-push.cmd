@echo on
@setlocal enableDelayedExpansion

@set PACKAGE=%~1
@set REPOSITORY=%~2
@set REPOSITORY_TOKEN=%~3

@set TEMP_DIR=%TEMP%\%PACKAGE%

mkdir "%TEMP_DIR%"
choco pack "%PACKAGE%\%PACKAGE%.nuspec" --outputdirectory "%TEMP_DIR%"
@if %ERRORLEVEL% NEQ 0 (
  echo "choco pack command execution failed."
  exit %ERRORLEVEL%
)

copy /Y "%TEMP_DIR%" .packed

pushd "%TEMP_DIR%"
choco push -source "%REPOSITORY%" --apikey "%REPOSITORY_TOKEN%"
@if %ERRORLEVEL% NEQ 0 (
  echo "choco push command execution failed"
  popd
  exit %ERRORLEVEL%
)
popd
