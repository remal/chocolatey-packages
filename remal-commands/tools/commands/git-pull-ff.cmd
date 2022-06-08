@echo off
setlocal enableDelayedExpansion
set GIT_TERMINAL_PROMPT=0
set GIT_ASK_YESNO=false
echo Fetching %CD%
git fetch --all --recurse-submodules=yes --force
echo Pulling %CD%
git diff-index HEAD | findstr /C:"0"
if !ERRORLEVEL! NEQ 0 (
    git pull --all --ff-only --recurse-submodules=yes
    if !ERRORLEVEL! NEQ 0 (
        git rebase --abort
    )
) else (
    echo error: There are uncommited changes!
)
echo Running GC
git gc --auto --aggressive --quiet
git rerere gc
echo.
