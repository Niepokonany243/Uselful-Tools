@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Wikipedia Fixer
echo Options:
echo 1. Fix From File
echo 2. Fix From Paste
set /p option="Enter option (1 or 2): "

if "%option%"=="1" goto fix_from_file
if "%option%"=="2" goto fix_from_paste
goto menu

:fix_from_file
set /p filename="Enter the name of the file (with extension): "
set /p format="Select format (txt, json, or custom): "
set /p output_option="Select output option (1. Create File, 2. Copy): "

set "output_file=output.txt"
if "%format%"=="custom" (
    set /p custom_format="Enter custom format: "
)

set "fixed_text="

for /f "delims=" %%i in ('type "%filename%" ^| findstr /v /r "\[.*\]"') do (
    set "line=%%i"
    if "%format%"=="txt" (
        set "line=!line:*]=!"
    ) else if "%format%"=="json" (
        set "line=!line:*: \"=!"
        set "line=!line:\",=!"
    ) else if "%format%"=="custom" (
        set "line=!line:%custom_format%=!"
    )

    if defined line (
        set "fixed_text=!fixed_text!!line!\n"
    )
)

if "%output_option%"=="1" (
    echo !fixed_text! > %output_file%
    echo File created successfully: %output_file%
) else if "%output_option%"=="2" (
    echo !fixed_text! | clip
    echo Text copied to clipboard.
)

pause
goto menu

:fix_from_paste
set /p input_text="Paste or type the text to fix: "
set /p output_option="Select output option (1. Create File, 2. Copy): "

set "output_file=output.txt"

set "fixed_text="

for /f "delims=" %%i in ('echo %input_text% ^| findstr /v /r "\[.*\]"') do (
    set "line=%%i"

    if defined line (
        set "fixed_text=!fixed_text!!line!\n"
    )
}

if "%output_option%"=="1" (
    echo !fixed_text! > %output_file%
    echo File created successfully: %output_file%
) else if "%output_option%"=="2" (
    echo !fixed_text! | clip
    echo Text copied to clipboard.
)

pause
goto menu
