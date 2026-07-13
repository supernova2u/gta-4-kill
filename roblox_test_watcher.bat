@echo off
:: ===== TEST SETTINGS - ROBLOX =====
set EXENAME=RobloxPlayerBeta.exe
set GAMEPATH=C:\Path\To\Roblox\Versions\version-XXXXXXXXXX
set LOCKEDNAME=RobloxPlayerBeta_locked.exe
set MINUTES=1
:: ===================================

:loop
tasklist /FI "IMAGENAME eq %EXENAME%" 2>NUL | find /I "%EXENAME%" >NUL
if "%ERRORLEVEL%"=="0" goto found
timeout /t 5 /nobreak >NUL
goto loop

:found
echo [%date% %time%] Roblox detected. Waiting %MINUTES% minute(s)...
set /a WAITSEC=%MINUTES%*60
timeout /t %WAITSEC% /nobreak >NUL

echo Killing %EXENAME%...
taskkill /IM %EXENAME% /F
if errorlevel 1 (
    echo WARNING: taskkill failed or process already closed. errorlevel=%ERRORLEVEL%
)

timeout /t 2 /nobreak >NUL

echo Renaming exe to lock it...
ren "%GAMEPATH%\%EXENAME%" %LOCKEDNAME%
if errorlevel 1 (
    echo ERROR: rename failed. This is usually a PERMISSIONS issue.
    echo Try running this script as Administrator, or check GAMEPATH is correct.
    echo GAMEPATH is currently: %GAMEPATH%
) else (
    echo Success: renamed to %LOCKEDNAME%
)

pause
goto loop
