@echo off
setlocal enabledelayedexpansion

:menu
cls
echo ============================
echo        Main Menu
echo ============================
echo 1. Show Computer Parameters
echo 2. Show Disk Space
echo 3. Show Computer Components
echo 4. Exit
echo ============================
set /p choice="Please select an option (1-4): "

if "%choice%"=="1" goto parameters
if "%choice%"=="2" goto diskspace
if "%choice%"=="3" goto components
if "%choice%"=="4" exit
goto menu

:parameters
cls
echo ============================
echo     Computer Parameters
echo ============================
echo Processor Information:
wmic cpu get name, CurrentClockSpeed
echo.
echo RAM Information:
wmic memorychip get capacity
echo.
echo Graphics Card Information:
wmic path win32_videocontroller get name
echo ============================
pause
goto menu

:diskspace
cls
echo ============================
echo     Disk Space Information
echo ============================
for /f "skip=1 tokens=1,2,3" %%a in ('wmic logicaldisk get name^, size^, freespace') do (
    set "drive=%%a"
    set "size=%%b"
    set "freespace=%%c"
    if defined drive (
        echo Drive !drive!: Size: !size! bytes, Free Space: !freespace! bytes
    )
)
echo ============================
pause
goto menu

:components
cls
echo ============================
echo     Computer Components
echo ============================
echo Network Card Information:
wmic nic get name, manufacturer, description
echo.
echo Motherboard Information:
wmic baseboard get product, manufacturer
echo.
echo Storage Devices:
wmic diskdrive get model, size
echo ============================
pause
goto menu

:EOF