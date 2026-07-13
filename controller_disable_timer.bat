@echo off
:: Must be run as Administrator - disabling devices requires admin rights.

:: ===== SETTINGS =====
set MINUTES=40
:: =====================

set CONNECTED_SECONDS=0
set /a TARGET_SECONDS=%MINUTES%*60

echo Watching for controller connection... will disable it after %MINUTES% continuous minute(s).
echo (This window must stay open in the background for the timer to work.)
echo.

:loop
for /f %%i in ('powershell -NoProfile -Command "if ((Get-PnpDevice -Class HIDClass -Status OK -ErrorAction SilentlyContinue | Where-Object {$_.FriendlyName -match 'controller|gamepad|xbox|xinput'})) {Write-Output 1} else {Write-Output 0}"') do set CONTROLLER=%%i

if "%CONTROLLER%"=="1" (
    set /a CONNECTED_SECONDS=%CONNECTED_SECONDS%+5
    echo Controller connected for %CONNECTED_SECONDS% of %TARGET_SECONDS% seconds...
) else (
    if not "%CONNECTED_SECONDS%"=="0" echo Controller disconnected. Resetting timer.
    set CONNECTED_SECONDS=0
)

if %CONNECTED_SECONDS% GEQ %TARGET_SECONDS% goto trigger

timeout /t 5 /nobreak >NUL
goto loop

:trigger
echo.
echo [%date% %time%] Controller connected for %MINUTES% minute(s). Disabling it now...
echo.

powershell -NoProfile -Command "Get-PnpDevice -Class HIDClass -Status OK | Where-Object {$_.FriendlyName -match 'controller|gamepad|xbox|xinput'} | Select-Object FriendlyName, InstanceId"

powershell -NoProfile -Command "Get-PnpDevice -Class HIDClass -Status OK | Where-Object {$_.FriendlyName -match 'controller|gamepad|xbox|xinput'} | Disable-PnpDevice -Confirm:$false"

echo.
echo Done. Controller disabled - it will stay disabled until you run controller_enable.bat manually.
pause
