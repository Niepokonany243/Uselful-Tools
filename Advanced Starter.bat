@echo off
setlocal enabledelayedexpansion

echo 0- Just Start Neworld
echo 1- 1GB
echo 2- 2GB
echo 3- 3GB
echo 4- 4GB
echo 5- 5GB
echo 6- 6GB
echo 7- 7GB
echo 8- 8GB
echo 9- Custom
set /p ramChoice="Enter the RAM option number (0-9): "

if not defined ramChoice (
    echo Invalid choice. Exiting.
    exit /b 1
)

if !ramChoice! equ 0 (
    set "ram=2g"
) else if !ramChoice! lss 9 (
    set "ram=!ramChoice!g"
) else if !ramChoice! equ 9 (
    set /p customRam="Enter the amount of RAM (in GB): "
    set "ram=!customRam!g"

    for /f "skip=1 tokens=2 delims=," %%a in ('systeminfo ^| findstr "Total Physical Memory"') do (
        set "totalMemory=%%a"
        set "totalMemory=!totalMemory:~1,-3!"
    )

    set /a totalMemoryInGB=totalMemory / 1024 / 1024
    if !customRam! gtr !totalMemoryInGB! (
        echo Warning: Selected RAM exceeds available physical memory.
        set /p continueChoice="Continue with maximum available RAM? (1- No, 2- Yes): "
        if !continueChoice! equ 1 exit /b 1
        if !continueChoice! equ 2 set "ram=!totalMemoryInGB!g"
    )
) else (
    echo Invalid choice. Exiting.
    exit /b 1
)

if !ramChoice! equ 0 (
    java -Xms2g -Xmx2g -jar NW.JAR
    exit /b
)

echo Select process priority:
for /l %%i in (1, 1, 3) do echo %%i- Priority %%i
set /p priorityChoice="Enter the process priority option number (1-3): "

if not defined priorityChoice (
    echo Invalid choice. Exiting.
    exit /b 1
)

echo Select application to run:
echo 1- NW
echo 2- Aoc2
echo 3- Aoc2[java]
echo 4- BEII[jar]
echo 5- BE2
echo 6- More Options
echo 7- Manual
set /p appChoice="Enter the application option number (1-7): "

if not defined appChoice (
    echo Invalid choice. Exiting.
    exit /b 1
)

set "priority="

if !priorityChoice! lss 4 set "priority=Priority !priorityChoice!"

if !appChoice! equ 1 java -Xms!ram! -Xmx!ram! -jar NW.JAR
if !appChoice! equ 2 Aoc2.exe
if !appChoice! equ 3 java -Xms!ram! -Xmx!ram! -jar Aoc2.jar
if !appChoice! equ 4 java -Xms!ram! -Xmx!ram! -jar BEII.jar
if !appChoice! equ 5 BE2.exe
if !appChoice! equ 6 (
    echo More options:
    echo 1- BEII[jar]
    echo 2- Uwut_Engine_v1.6.2
    set /p moreOption="Enter the more option number (1-2): "
    if !moreOption! equ 1 java -Xms!ram! -Xmx!ram! -jar BEII.jar
    if !moreOption! equ 2 (
        set /p newerVersion="Is there a newer version of Uwut_Engine? (Yes/No): "
        if /i !newerVersion! equ "Yes" (
            for /L %%i in (0,1,9) do (
                set "version=1.%%i.0"
                if exist "Uwut_Engine_v!version!.exe" (
                    Uwut_Engine_v!version!.exe
                    exit /b
                )
            )
            echo No newer version found. Running Uwut_Engine_v1.6.2.exe
            Uwut_Engine_v1.6.2.exe
        ) else if /i !newerVersion! equ "No" (
            Uwut_Engine_v1.6.2.exe
        ) else (
            echo Invalid option. Exiting.
            exit /b 1
        )
    )
)
if !appChoice! equ 7 (
    set /p appName="Enter the name of the application (without extension): "
    set /p appType="Enter the application type (1- exe, 2- jar): "
    if !appType! equ 1 (
        !appName!.exe
    ) else if !appType! equ 2 (
        java -Xms!ram! -Xmx!ram! -jar !appName!.jar
    ) else (
        echo Invalid application type. Exiting.
        exit /b 1
    )
)

set /p optimizeChoice="Do you want to optimize the game? (1- No, 2- Yes): "
if /i !optimizeChoice! equ 2 (
    echo Optimizing the game...
    REM Add optimization commands here
)

if "%priority%" neq "" (
    wmic process where name="java.exe" call setpriority "%priority%"
)
