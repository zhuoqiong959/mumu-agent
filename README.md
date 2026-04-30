# MuMu Agent 🤖

跨平台智能AI助手，支持电脑控制、WebUI界面、多模型集成、技能自我进化。

## ✨ 特性

- 💬 **多模型支持**: OpenAI、Anthropic、阿里通义、智谱GLM、Ollama本地模型
- 🖥️ **电脑控制**: 模拟鼠标键盘操作，远程控制电脑
- 🌐 **WebUI界面**: 浏览器可视化操作，内置技能管理
- 🧠 **自我进化**: 从复杂任务中自动学习创建技能
- 💾 **持久记忆**: SQLite存储，跨会话记忆
- 🔒 **安全可靠**: 危险命令拦截，API密钥保护

## 📦 安装

### 从GitHub安装

```powershell
# 使用 pip 安装
pip install git+https://github.com/zhuoqiong959/mumu-agent.git

# 或克隆后安装
git clone https://github.com/zhuoqiong959/mumu-agent.git
cd mumu-agent
pip install -e .
```

### 完整安装（含全部功能）

```powershell
pip install -e ".[all]"
```

### Windows 一键安装

```powershell
# 下载并双击运行 setup.bat
```

## 🚀 快速开始

### 1. 配置API密钥

```powershell
# 设置环境变量
set OPENROUTER_API_KEY=sk-or-your-key
set ANTHROPIC_API_KEY=sk-ant-your-key

# 或编辑配置
notepad %USERPROFILE%\.mumu-agent\.env
```

### 2. 启动方式

```powershell
# 方式1: WebUI 界面（推荐）
mumu webui
# 然后浏览器打开 http://127.0.0.1:3000

# 方式2: 命令行对话
mumu chat

# 方式3: 单次查询
mumu chat -q "你好"
```

### 3. 启动Gateway服务

```powershell
# 启动API网关
mumu gateway

# 或后台运行
mumu gateway run
```

## 🌐 WebUI 使用

### 启动WebUI

```powershell
mumu webui
```

浏览器自动打开 `http://127.0.0.1:3000`

### WebUI 功能

| 功能 | 说明 |
|------|------|
| 💬 对话 | 与AI助手聊天 |
| 🛠️ 技能管理 | 创建、编辑、删除技能 |
| ⚙️ 设置 | 配置模型、API密钥 |
| 🖥️ 电脑控制 | 远程操作电脑 |

### 直接访问（无浏览器）

首次启动会在 `~/.mumu-agent/` 目录生成令牌，访问:

```
http://127.0.0.1:3000?token=你的令牌
```

## 🖥️ 电脑控制命令

| 命令 | 说明 | 示例 |
|------|------|------|
| `打开 [应用]` | 启动应用 | `打开微信` |
| `关闭 [应用]` | 关闭应用 | `关闭浏览器` |
| `点击 [x, y]` | 鼠标点击 | `点击 500,300` |
| `双击 [x, y]` | 双击 | `双击 100,200` |
| `输入 [文字]` | 键盘输入 | `输入 Hello` |
| `滚动 [像素]` | 页面滚动 | `滚动 100` |
| `截图` | 屏幕截图 | `截图` |
| `最小化` | 最小化窗口 | `最小化` |
| `最大化` | 最大化窗口 | `最大化` |

## 🛠️ 技能系统

### 创建技能

在 WebUI → 技能管理 → 创建技能，或编写 SKILL.md:

```markdown
---
name: my-skill
description: 我的技能描述
---

# 技能说明

## 触发条件
当用户说"执行xxx"时触发。

## 执行步骤
1. 步骤一
2. 步骤二

## 示例
用户: "执行xxx"
助手: "好的，正在执行..."
```

### 内置技能

| 技能 | 触发词 | 说明 |
|------|--------|------|
| 代码审查 | 代码审查 | 分析代码问题 |
| 搜索 | 搜索 | 网络搜索 |
| 截图 | 截图 | 截取屏幕 |

## 📡 API 接口

Gateway 启动后提供 REST API:

```
http://127.0.0.1:8642/chat
http://127.0.0.1:8642/control/<action>
http://127.0.0.1:8642/api/skills
```

认证: `Authorization: Bearer <token>`

## 🔧 配置

配置文件位置: `~/.mumu-agent/config.yaml`

```yaml
model:
  provider: openrouter  # openrouter, anthropic, openai, ollama, dashscope, zhipu
  model: auto          # 自动选择最佳模型
  api_key: ${OPENROUTER_API_KEY}

gateway:
  port: 8642
  host: 127.0.0.1

memory:
  enabled: true
  db_path: ~/.mumu-agent/memory.db

security:
  approve_dangerous: false
  allowed_commands:
    - code_editor
    - browser
    - terminal
```

## 🔐 安全

- 🔑 API密钥存储在本地，不上传
- ⚠️ 危险命令需确认
- 🛡️ 敏感操作白名单

## 📋 系统要求

- Windows 10/11 或 macOS 10.15+
- Python 3.10+
- 4GB+ RAM
- 网络连接（用于API调用）

## 🐛 故障排除

### WebUI 打不开

```powershell
# 检查端口占用
netstat -ano | findstr 3000

# 尝试其他端口
mumu webui --port 3001
```

### Gateway 连接失败

```powershell
# 重启 Gateway
mumu gateway stop
mumu gateway start

# 检查状态
mumu gateway status
```

### 电脑控制不工作

```powershell
# 重新安装依赖
pip install -e ".[control]"
```

## 📄 许可证

MIT License

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📚 相关链接

- GitHub: https://github.com/zhuoqiong959/mumu-agent
- 文档: (待补充)

---

**MuMu Agent** - 让AI助手更强大 🚀
