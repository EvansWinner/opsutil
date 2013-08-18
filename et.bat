@echo off
:: Evans Winner
:: 2006
setlocal

if [%1] == [] goto help
if [%1] == [/?] goto help
if [%1] == [/h] goto help
if [%1] == [/help] goto help
if [%1] == [h] goto help
if [%1] == [help] goto help

color 0d
cls
echo wscript.sleep ^(60000^) > et.vbs

set job=%2
if [%2] == [] set job=unspecified
for /l %%n in (%1, -1, 1) do (
	cls
	echo.
	echo 	ETA for ^`%job%^' -- %%n minutes...
	cscript.exe et.vbs > nul
)

cls
echo.
echo 	Timing estimate for ^`%job%^' is DONE.

del et.vbs
color 4f
pause
cls
color
goto :end

:help
echo.
echo et.bat ^(i.e., ^`egg timer^'^) - countdown timer in minutes
echo.
echo USE: et m ^[string^]
echo.
echo    where ^`m^' is a number representing the number
echo    of minutes to count down ^(no seconds^) and ^`string^'
echo    is any string you wish to use as a mnemonic to 
echo    remember what you are timing ^(will be echoed to the
echo    screen when timing.^)
echo.
echo REQUIRES: cscript.exe

:end
endlocal
