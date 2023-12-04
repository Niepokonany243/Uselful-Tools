setlocal enabledelayedexpansion
@echo off

:menu
cls
echo Fast Renamer
echo Options:
echo 1 Rename Certain Files
echo 2 Rename Everything
set /p option="Enter option (1 or 2): "

if "%option%"=="1" goto rename_certain_files
if "%option%"=="2" goto rename_everything
goto menu

:rename_certain_files
set /p search="Enter the text to search for: "
set /p replace="Enter the text to replace with: "

for %%f in (*%search%*) do (
    set "file=%%~f"
    set "newname=!file:%search%=%replace%!"
    ren "%%~f" "!newname!"
)

echo Files renamed successfully!
pause
goto menu

:rename_everything
set /p newname="Enter the new name for all files: "

for %%f in (*) do (
    set "file=%%~f"
    set "newname=!file:%newname%=!"
    ren "%%~f" "%newname%"
)

echo All files renamed successfully!
pause
goto menu
