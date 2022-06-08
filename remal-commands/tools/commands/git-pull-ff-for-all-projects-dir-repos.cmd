@echo off
setlocal enableDelayedExpansion

set LOG_FILE=%USERPROFILE%\%~nx0.log
call leave-only-last-n-lines "%LOG_FILE%" 1000

echo. >> "%LOG_FILE%" 2>&1
echo %date% %time% >> "%LOG_FILE%" 2>&1
call :main >> "%LOG_FILE%" 2>&1
exit /b

:main
pushd "%USERPROFILE%\projects"
set GIT_TERMINAL_PROMPT=0
set GIT_ASK_YESNO=false
echo Finding all .git directories...
for /F "tokens=*" %%G in ('dir .git /AD /S /B') do (
    pushd "%%G\.."
    echo Processing %%G

    if exist "%%G\..\..\.do-not-pull-periodically" (
        echo Skipping periodic pull
    ) else (
        echo Fetching
        git fetch --all --recurse-submodules=yes --force
        echo Pulling %%G
        git diff-index HEAD | findstr /C:"0" 2>&1
        if !ERRORLEVEL! NEQ 0 (
            git pull --all --ff-only --recurse-submodules=yes
            if !ERRORLEVEL! NEQ 0 (
                git rebase --abort
            )
        ) else (
            echo error: There are uncommited changes!
        )
    )

    echo Running GC
    git gc --aggressive --quiet
    git rerere gc

    echo.
    popd
)
popd
