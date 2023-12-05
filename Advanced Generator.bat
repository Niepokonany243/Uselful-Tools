@echo off
setlocal enabledelayedexpansion

:main_menu
cls
echo 1. Number Generator
echo 2. Password Generator
echo 3. Generate Folder
set /p choice="Select an option (1/2/3): "

if "%choice%"=="1" (
    call :number_generator
) else if "%choice%"=="2" (
    call :password_generator
) else if "%choice%"=="3" (
    call :generate_folder
) else (
    echo Invalid option. Please try again.
    timeout /nobreak /t 2 >nul
    goto main_menu
)

:number_generator
cls
echo Number Generator
echo 1. From
echo 2. To
echo 3. Generate
set /p from="Enter 'From' number: "
set /p to="Enter 'To' number: "
set /p generate_choice="Select an option (1/2/3): "

if "%generate_choice%"=="1" (
    echo Copying numbers from %from% to %to%...
    echo. >desc.txt
    for /l %%i in (%from%, 1, %to%) do (
        echo %%i >>desc.txt
    )
    echo Copy successful!
    timeout /nobreak /t 2 >nul
) else if "%generate_choice%"=="2" (
    call :generate_file
) else if "%generate_choice%"=="3" (
    call :generate_file
) else (
    echo Invalid option. Please try again.
    timeout /nobreak /t 2 >nul
    goto number_generator
)
goto main_menu

:generate_file
cls
echo File Format Options
echo 1. txt
echo 2. json
echo 3. html
set /p format_choice="Select a format (1/2/3): "
if "%format_choice%"=="1" (
    set "format=txt"
) else if "%format_choice%"=="2" (
    set "format=json"
) else if "%format_choice%"=="3" (
    set "format=html"
) else (
    echo Invalid option. Please try again.
    timeout /nobreak /t 2 >nul
    goto generate_file
)

echo Creating file with format %format%...
echo. >output.%format%
for /l %%i in (%from%, 1, %to%) do (
    echo %%i >>output.%format%
)
echo File creation successful!
timeout /nobreak /t 2 >nul
goto main_menu

:password_generator
cls
echo Password Generator
echo 1. Select Format
echo 2. Settings
echo 3. Generate
set /p password_choice="Select an option (1/2/3): "

if "%password_choice%"=="1" (
    call :select_format
) else if "%password_choice%"=="2" (
    echo Settings not implemented.
    timeout /nobreak /t 2 >nul
    goto password_generator
) else if "%password_choice%"=="3" (
    call :generate_password
) else (
    echo Invalid option. Please try again.
    timeout /nobreak /t 2 >nul
    goto password_generator
)

:select_format
cls
echo Select Format
echo 1. txt
echo 2. json
echo 3. html
set /p password_format="Select a format (1/2/3): "
if "%password_format%"=="1" (
    set "password_format=txt"
) else if "%password_format%"=="2" (
    set "password_format=json"
) else if "%password_format%"=="3" (
    set "password_format=html"
) else (
    echo Invalid option. Please try again.
    timeout /nobreak /t 2 >nul
    goto select_format
)
echo Format selected: %password_format%
timeout /nobreak /t 2 >nul
goto main_menu

:generate_password
cls
if not defined password_format (
    echo Please select a format first.
    timeout /nobreak /t 2 >nul
    goto password_generator
)

echo Generating password...
echo Password123 > output.%password_format%
echo Password generation successful!
timeout /nobreak /t 2 >nul
goto main_menu

:generate_folder
cls
set /p folder_name="Enter folder name: "
md "%folder_name%"
echo Folder '%folder_name%' created successfully!
timeout /nobreak /t 2 >nul
goto main_menu
