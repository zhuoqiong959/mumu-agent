@echo off
chcp 65001 >nul 2>&1
title MuMu Agent Installer

echo ========================================
echo     MuMu Agent Installer
echo ========================================
echo.

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found!
    echo Please install Python 3.10+ from https://python.org
    pause
    exit /b 1
)

echo [OK] Python found
python --version

:: Install
echo.
echo Installing MuMu Agent...
pip install -e .

if errorlevel 1 (
    echo.
    echo [ERROR] Installation failed!
    echo Try: pip install -e .
    pause
    exit /b 1
)

echo.
echo ========================================
echo     Installation Complete!
echo ========================================
echo.
echo Commands:
echo   mumu webui    - Start WebUI
echo   mumu chat    - Start Chat
echo   mumu skills  - Manage Skills
echo.
echo WebUI: http://127.0.0.1:3000
echo.
pause
