@echo off
@setlocal enableDelayedExpansion

for /f %%a in ('wmic Path Win32_UTCTime get Year^,Month^,Day^,Hour^,Minute^,Second /Format:List ^| findstr "="') do (set %%a)
set Second=0%Second%
set Second=%Second:~-2%
set Minute=0%Minute%
set Minute=%Minute:~-2%
set Hour=0%Hour%
set Hour=%Hour:~-2%
set Day=0%Day%
set Day=%Day:~-2%
set Month=0%Month%
set Month=%Month:~-2%
set UTCTIME=%Hour%:%Minute%:%Second%
set UTCDATE=%Year%%Month%%Day%
set VERSION=%Year%%Month%%Day%%Hour%%Minute%%Second%
echo %VERSION%

@set PACKAGE=%~1
