@echo off
setLocal enableDelayedExpansion

set BRANCH_NAME=%~1
if "%BRANCH_NAME%" == "" goto usage
echo BRANCH_NAME: %BRANCH_NAME%

set COMMIT_MESSAGE=%~2
if "%COMMIT_MESSAGE%" == "" goto usage
echo COMMIT_MESSAGE: %COMMIT_MESSAGE%
echo.


set GIT_TERMINAL_PROMPT=0
set GIT_ASK_YESNO=false

if exist .git\ (
    call :processGitDir ".git"
    if !ERRORLEVEL! neq 0 ( exit /b !ERRORLEVEL! )
    echo.
    echo.
) else (
    for /F "tokens=*" %%G in ('dir .git /AD /S /B') do (
        call :processGitDir "%%G"
        if !ERRORLEVEL! neq 0 ( exit /b !ERRORLEVEL! )
        echo.
        echo.
    )
)

popd

call c:\Users\Semyon_Levin\projects\.mine\chocolatey-packages\remal-commands\tools\commands\pause-if-not-interactive.cmd

exit /b 0


:processGitDir
pushd "%1\.."
echo Processing %CD%

git diff-index HEAD | findstr /C:"1" >nul 2>&1
if !ERRORLEVEL! neq 0 (
    git status >nul 2>&1
    git diff-index HEAD | findstr /C:"0" 2>&1
    if !ERRORLEVEL! neq 0 (
        echo There are NO uncommited changes 1>&2
        exit /b 0
    )
)

set CURRENT_BRANCH=
for /F "tokens=* USEBACKQ" %%F IN (`git rev-parse --abbrev-ref HEAD`) do set CURRENT_BRANCH=%%F
echo Current branch: !CURRENT_BRANCH!
if "!CURRENT_BRANCH!" neq "%BRANCH_NAME%" (
    echo git checkout -b "%BRANCH_NAME%"
    git checkout -b "%BRANCH_NAME%"
    if !ERRORLEVEL! neq 0 (
        echo Git checkout failed 1>&2
        exit /b 1
    )
)

echo git add --all
git add --all

echo git commit -m "%COMMIT_MESSAGE%"
git commit -m "%COMMIT_MESSAGE%"
if !ERRORLEVEL! neq 0 (
    echo Git commit failed 1>&2
    exit /b 1
)

echo git push --force-with-lease "--push-option=merge_request.create" "--push-option=merge_request.remove_source_branch" --set-upstream origin "%BRANCH_NAME%"
git push --force-with-lease "--push-option=merge_request.create" "--push-option=merge_request.remove_source_branch" --set-upstream origin "%BRANCH_NAME%"
if !ERRORLEVEL! neq 0 (
    echo Git push failed 1>&2
    exit /b 1
)

exit /b 0


:usage
echo Usage:
echo %~n0 ^<branch^> ^<commit message^>
exit /b 1
