@echo off
setlocal enableDelayedExpansion

set /p LAST_PUBLISHED_COMMIT=<.last-publish.commit
echo Last published commit: !LAST_PUBLISHED_COMMIT!

set CHANGED_FILES=
for /F "delims=" %%h in ('git log "--format=%%H" --reverse !LAST_PUBLISHED_COMMIT!^..') do (
    set COMMIT_HASH=%%h
    set COMMIT_MESSAGE=
    for /F "delims=" %%m in ('git log "--format=%%B" --reverse -n 1 !COMMIT_HASH!') do (
        if "!COMMIT_MESSAGE!" == "" (
            set COMMIT_MESSAGE=%%m
        )
    )
    if /i "!COMMIT_MESSAGE:~0,12!" neq "[push-back] " (
        echo Processing commit !COMMIT_HASH!: !COMMIT_MESSAGE!
        for /F "delims=" %%f in ('git show "--pretty=format:" --name-only !COMMIT_HASH!') do (
            set CHANGED_FILE=%%f
            echo "!CHANGED_FILES!" | findstr /C:":!CHANGED_FILE!" 1>nul
            if errorlevel 1 (
                set CHANGED_FILES=!CHANGED_FILES!:!CHANGED_FILE!
            )
        )
    )
)

echo Changed files: !CHANGED_FILES!

if "!GITHUB_OUTPUT!" neq "" (
    echo all=!CHANGED_FILES!>>!GITHUB_OUTPUT!
)

if "!GITHUB_ENV!" neq "" (
    echo CHANGED_FILES=!CHANGED_FILES!>>!GITHUB_ENV!
)
