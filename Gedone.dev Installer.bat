@echo off
title Gedone.dev Installer
color 5
set "install_path=%USERPROFILE%\Desktop"
cd /d "%install_path%"

:check_prerequisites
cls
echo ======================================================
echo Gedone.dev Installer
echo ======================================================
echo.
echo Checking prerequisites...
for /l %%x in (1, 1, 4) do (
    echo.
    for /f "delims=" %%a in ('echo %%x') do (
        <nul set /p "=#"
        timeout /t 1 /nobreak >nul
    )
)

REM Check for Git
where git >nul 2>&1 || (
    echo Git not found. Installing Git...
    start /wait "" "ms-settings:appsfeatures?appid=Microsoft.Git&plcid=0x409" && call :install_git
    taskkill /IM ms-settings:appsfeatures /F
)

REM Check for git-lfs
where git-lfs >nul 2>&1 || (
    echo git-lfs not found. Installing git-lfs...
    powershell -Command "iex (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/git-lfs/git-lfs/main/install.ps1')" && call :install_git_lfs
)

REM Check for Node.js
where node >nul 2>&1 || (
    echo Node.js not found. Installing Node.js...
    start /wait "" "https://nodejs.org/dist/v16.14.0/node-v16.14.0-x64.msi" /qn
)

:menu
cls
echo ======================================================
echo Gedone.dev Installer
echo ======================================================
echo.
echo 1. Install ReaperV2
echo 2. Install Rust Mouse Script
echo 3. ---
echo 4. Open Installation Path
echo 5. Exit
echo.
set /p choice=Select an option: 

if "%choice%"=="1" (
    echo Installing ReaperV2...
    git clone https://github.com/CedrickGD/ReaperV2-.git
    echo Cloning repository...
    timeout /t 2 /nobreak >nul
    echo Cloned repository.
    echo.
    cd ReaperV2-
    echo Installing ReaperV2...

) else if "%choice%"=="2" (
    echo Installing Rust Mouse Script
    git clone https://github.com/CedrickGD/Rust-Mouse-Script.git
    echo Downloading Script...
    timeout /t 2 /nobreak >nul
    echo Script downloaded! 
    echo. 
    echo Check Your Desktop!

) else if "%choice%"=="4" (
    echo Opening default installation path...
    start "" "%install_path%"
    timeout /t 2 /nobreak >nul
    goto :menu

) else if "%choice%"=="5" (
    echo Exiting...
    exit

) else (
    echo Invalid option. Please try again.
    pause
    goto menu
)

:install_git
REM Install Git silently
powershell -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://git-scm.com/download/win?id=set-exec&dl_code=raw.githubusercontent.com-git-scm-git-for-windows-MINGW_PROXY-setup-1.exe')) -ArgumentList '/VERYSILENT', '/NORESTART'"
goto :menu

:install_git_lfs
REM Install git-lfs silently
git-lfs install --silent
goto :menu