@echo off
:: ===== SETTINGS - EDIT THESE TO MATCH YOUR INSTALL =====
set EXENAME=GTAIV.exe
set GAMEPATH=C:\Path\To\GTAIV
set LOCKEDNAME=GTAIV_locked.exe
set MINUTES=40
:: ========================================================

:loop
tasklist /FI "IMAGENAME eq %EXENAME%" 2>NUL | find /I "%EXENAME%" >NUL
if "%ERRORLEVEL%"=="0" goto found
timeout /t 5 /nobreak >NUL
goto loop

:found
set /a WAITSEC=%MINUTES%*60
timeout /t %WAITSEC% /nobreak >NUL
taskkill /IM %EXENAME% /F
ren "%GAMEPATH%\%EXENAME%" %LOCKEDNAME%
goto loop
