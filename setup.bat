@echo off
chcp 65001 >nul
title MuMu Agent 安装程序

echo ╔════════════════════════════════════════╗
echo ║     MuMu Agent 安装向导 v1.0.0        ║
echo ╚════════════════════════════════════════╝
echo.

:: 检查 Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [!] 未找到 Python，请先安装 Python 3.10+
    echo    下载地址: https://www.python.org/downloads/
    pause
    exit /b 1
)

echo [*] 检测到 Python 已安装
echo.

:: 检查 pip
pip --version >nul 2>&1
if errorlevel 1 (
    echo [!] pip 未安装，尝试安装...
    python -m ensurepip --upgrade
)

echo [*] 正在安装 MuMu Agent...
echo.

:: 安装核心依赖
echo [*] 安装核心依赖...
pip install requests pyyaml duckduckgo-search pillow aiohttp aiosqlite tiktoken

:: 安装完整依赖
echo.
echo [*] 安装完整功能（含全部模型支持）...
pip install -e ".[all]"

if errorlevel 1 (
    echo.
    echo [!] 安装失败，尝试基础安装...
    pip install -e ".[models]"
)

echo.
echo ╔════════════════════════════════════════╗
echo ║         安装完成！                     ║
echo ╚════════════════════════════════════════╝
echo.
echo 接下来：
echo   1. 配置 API 密钥：
echo      set OPENROUTER_API_KEY=sk-your-key
echo.
echo   2. 启动 WebUI：
echo      mumu webui
echo.
echo   3. 或启动命令行：
echo      mumu chat
echo.
echo [*] 是否立即启动？ (Y/N)
choice /c YN /n
if errorlevel 1 (
    echo.
    echo [*] 启动 MuMu Agent...
    mumu webui
)

pause
