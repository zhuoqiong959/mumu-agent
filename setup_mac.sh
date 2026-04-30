#!/bin/bash
# -*- coding: utf-8 -*-
"""
MuMu Agent macOS 安装脚本
"""

set -e

echo "========================================"
echo "      MuMu Agent 安装脚本"
echo "========================================"
echo ""

# 检查 Python
if ! command -v python3 &> /dev/null; then
    echo "[错误] 未检测到 Python，请先安装 Python 3.10+"
    echo "下载地址: https://www.python.org/downloads/mac-osx/"
    exit 1
fi

PYVER=$(python3 --version)
echo "检测到: $PYVER"

# 检查是否在虚拟环境
if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo ""
    echo "[提示] 建议在虚拟环境中安装"
    read -p "是否创建虚拟环境? (y/n, 默认y): " CREATE_VENV
    CREATE_VENV=${CREATE_VENV:-y}
    
    if [[ "$CREATE_VENV" == "y" ]]; then
        echo ""
        echo "[1/4] 创建虚拟环境..."
        python3 -m venv venv
        source venv/bin/activate
        echo "虚拟环境创建成功"
    fi
fi

echo ""
echo "[2/4] 安装依赖包..."

# 升级 pip
python3 -m pip install --upgrade pip -q

# 安装基础依赖
echo "安装基础依赖..."
pip install requests>=2.31.0 -q
pip install pyyaml>=6.0.1 -q
pip install duckduckgo-search>=6.2.0 -q
pip install aiohttp>=3.9.0 -q
pip install aiosqlite>=0.19.0 -q

# 安装模型依赖
echo "安装模型支持..."
pip install anthropic>=0.18.0 -q
pip install openai>=1.12.0 -q
pip install ollama>=0.1.0 -q
pip install dashscope>=1.14.0 -q
pip install zhipuai>=2.0.0 -q
pip install huggingface-hub>=0.20.0 -q

# 安装电脑控制依赖 (macOS)
echo "安装电脑控制依赖..."
pip install pyautogui>=0.9.54 -q
pip install pyscreeze>=0.1.28 -q
pip install pyobjc-framework-Quartz>=10.0 -q 2>/dev/null || true

# 安装本包
echo "安装 MuMu Agent..."
pip install -e . -q

echo ""
echo "[3/4] 配置环境变量..."

# 创建配置目录
mkdir -p ~/.mumu-agent

# 询问是否配置 API 密钥
read -p "是否配置 API 密钥? (y/n, 默认n): " API_CHOICE
if [[ "$API_CHOICE" == "y" ]]; then
    echo "请到以下网址获取 API 密钥:"
    echo "  OpenRouter: https://openrouter.ai/keys"
    echo "  Anthropic: https://console.anthropic.com/"
    echo "  阿里云: https://dashscope.console.aliyun.com/"
    echo ""
    
    read -p "请输入 OpenRouter API Key (可跳过): " OPENROUTER_KEY
    if [[ "$OPENROUTER_KEY" != "" ]]; then
        echo "OPENROUTER_API_KEY=$OPENROUTER_KEY" >> ~/.mumu-agent/.env
    fi
    
    read -p "请输入 Anthropic API Key (可跳过): " ANTHROPIC_KEY
    if [[ "$ANTHROPIC_KEY" != "" ]]; then
        echo "ANTHROPIC_API_KEY=$ANTHROPIC_KEY" >> ~/.mumu-agent/.env
    fi
    
    read -p "请输入阿里云 DashScope API Key (可跳过): " DASHSCOPE_KEY
    if [[ "$DASHSCOPE_KEY" != "" ]]; then
        echo "DASHSCOPE_API_KEY=$DASHSCOPE_KEY" >> ~/.mumu-agent/.env
    fi
fi

echo ""
echo "[4/4] 安装完成!"
echo ""

# 检查 Ollama
echo "[提示] 是否安装 Ollama 本地模型?"
echo "    下载地址: https://ollama.com/download"
echo "    安装后运行: ollama pull llama3.2"
echo ""

echo "========================================"
echo "      安装完成！使用方法："
echo "========================================"
echo ""
echo "1. 激活虚拟环境:"
echo "   source venv/bin/activate"
echo ""
echo "2. 运行 MuMu Agent:"
echo "   mumu --chat          # 交互式对话"
echo "   mumu --menu         # 中文菜单"
echo "   mumu -q \"你好\"       # 单次查询"
echo "   mumu --control       # 电脑控制模式"
echo ""
echo "3. 配置文件位置:"
echo "   ~/.mumu-agent/.env"
echo ""
