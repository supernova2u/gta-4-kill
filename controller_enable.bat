@echo off
:: Must be run as Administrator.

echo Searching for disabled controller devices...
powershell -NoProfile -Command "Get-PnpDevice -Class HIDClass | Where-Object {$_.FriendlyName -match 'controller|gamepad|xbox|xinput' -and $_.Status -eq 'Error'} | Select-Object FriendlyName, InstanceId"

echo.
echo ---------------------------------------------
echo The devices listed above will be RE-ENABLED.
echo ---------------------------------------------
pause

powershell -NoProfile -Command "Get-PnpDevice -Class HIDClass | Where-Object {$_.FriendlyName -match 'controller|gamepad|xbox|xinput' -and $_.Status -eq 'Error'} | Enable-PnpDevice -Confirm:$false"

echo.
echo Done. Controller(s) re-enabled.
pause
