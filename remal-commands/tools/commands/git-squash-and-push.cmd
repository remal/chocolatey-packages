@echo off
setlocal EnableDelayedExpansion

set BASE_BRANCH=%1
if "%BASE_BRANCH%" == "" goto usage

for /F "tokens=* USEBACKQ" %%A in (`git rev-parse --abbrev-ref HEAD`) do (set CURRENT_BRANCH=%%A)
if "%BASE_BRANCH%" == "%CURRENT_BRANCH%" (
    echo Current branch is base branch: %CURRENT_BRANCH%
    exit /B 1
)

for /F "tokens=* USEBACKQ" %%A in (`git branch --contains HEAD "--format=%%(refname:short)"`) do (
    if "%BASE_BRANCH%" == "%%A" (
        echo No commits were made to %CURRENT_BRANCH% branch
        exit /B 1
    )
)

git add --all
git commit -m "%date% %time%"

@rem git fetch origin "%BASE_BRANCH%:%BASE_BRANCH%"

for /F "tokens=* USEBACKQ" %%A in (`git log "%BASE_BRANCH%..%BRANCH%" "--pretty=format:%%s" --no-patch`) do (set FIRST_COMMIT_MESSAGE=%%A)

git reset --soft %BASE_BRANCH%
git add --all
git commit -m "%FIRST_COMMIT_MESSAGE%"
git push --force-with-lease

exit /B 0

:usage
echo Usage:
echo %~n0 ^<base branch^>
exit /B 1
