@echo off
:: ===== EDIT THIS PATH TO MATCH YOUR INSTALL =====
set GAMEPATH=C:\Path\To\GTAIV
set LOCKEDNAME=GTAIV_locked.exe
set EXENAME=GTAIV.exe
:: =================================================

ren "%GAMEPATH%\%LOCKEDNAME%" %EXENAME%
echo Game unlocked. You can play again.
pause
