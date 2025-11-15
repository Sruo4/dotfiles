# 🏠 Dotfiles

我的个人配置文件集合，使用 [GNU Stow](https://www.gnu.org/software/stow/) 进行管理，支持 macOS 和 Linux (Ubuntu)。

## ✨ 特性

- 📦 使用 Stow 进行配置文件管理，轻松链接和同步
- 🍎 支持 macOS (通过 Homebrew)
- 🐧 支持 Ubuntu/Linux (通过 apt)
- 🎨 遵循 XDG Base Directory 规范
- 🚀 开箱即用的开发环境配置
- 🔧 模块化设计，可选择性安装所需配置

## 📦 包含的配置

### 终端工具
- **Zsh** - 强大的 Shell，配置了历史记录、补全等功能
- **Starship** - 快速、可定制的终端提示符
- **Zellij** - 现代化的终端复用器
- **Ghostty** - 快速的 GPU 加速终端模拟器

### 编辑器
- **Neovim** - 完整的 Neovim 配置，包含多个插件：
  - Telescope - 模糊查找
  - Neo-tree - 文件树浏览
  - Blink - 自动补全
  - Lualine - 状态栏
  - Gitsigns - Git 集成
  - Treesitter - 语法高亮
  - 以及更多...

### 版本控制
- **Git** - Git 配置文件

### macOS 专属工具
- **AeroSpace** - 平铺窗口管理器
- **Hammerspoon** - macOS 自动化工具
- **Brewfile** - Homebrew 包管理配置，包含常用应用和工具

## 🚀 快速开始

### macOS 安装

1. **安装 Homebrew** (如果尚未安装)：
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. **克隆此仓库**：
```bash
git clone https://github.com/Sruo4/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

3. **安装 Stow**：
```bash
brew install stow
```

4. **（可选）使用 Brewfile 安装应用**：
```bash
brew bundle --file=brewfile/.Brewfile
```

5. **链接配置文件**：
```bash
# 链接 zshenv 到家目录
stow -R -t ~ zshenv

# 链接其他配置到 .config 目录
stow -R -t ~/.config aerospace git nvim zsh zellij ghostty hammerspoon

# 如果需要 Brewfile
stow -R -t ~ brewfile
```

6. **更改默认 Shell 为 Zsh**：
```bash
chsh -s $(which zsh)
```

### Ubuntu/Linux 安装

使用提供的自动化脚本进行一键安装：

```bash
curl -fsSL https://raw.githubusercontent.com/Sruo4/dotfiles/main/setup_ubuntu.sh -o setup_ubuntu.sh
chmod +x setup_ubuntu.sh
./setup_ubuntu.sh
```

此脚本将自动：
- 更新系统并安装基础依赖
- 安装 Starship 提示符
- 安装 Neovim 及其依赖（ripgrep, unzip, xclip）
- 克隆 dotfiles 仓库到 `~/.dotfiles`
- 使用 Stow 自动链接所有配置文件
- 将默认 Shell 更改为 Zsh

**安装完成后**，请重启终端或重新登录以使 Zsh 成为默认 Shell。

## 📁 目录结构

```
.
├── aerospace/       # AeroSpace 窗口管理器配置 (macOS)
├── brewfile/        # Homebrew 包列表 (macOS)
├── ghostty/         # Ghostty 终端配置
├── git/             # Git 配置
├── hammerspoon/     # Hammerspoon 自动化脚本 (macOS)
├── nvim/            # Neovim 配置
├── zellij/          # Zellij 终端复用器配置
├── zsh/             # Zsh Shell 配置
├── zshenv/          # Zsh 环境变量
├── setup_ubuntu.sh  # Ubuntu 自动安装脚本
└── .gitignore       # Git 忽略规则
```

每个目录都遵循 GNU Stow 的约定，包含可以链接到家目录或 `~/.config` 的配置文件。

## 🔧 自定义配置

### 添加私密配置

对于 API 密钥、令牌等敏感信息，可以创建本地配置文件：

```bash
# 在 ~/.config/zsh/.zshrc.local 中添加私密配置
touch ~/.config/zsh/.zshrc.local
```

此文件会被 `.gitignore` 忽略，不会被提交到版本控制。

### 选择性安装配置

不需要安装所有配置。使用 Stow 可以选择性地链接特定配置：

```bash
# 仅链接 Neovim 配置
stow -R -t ~/.config nvim

# 仅链接 Zsh 配置
stow -R -t ~/.config zsh
stow -R -t ~ zshenv
```

### 卸载配置

使用 Stow 的删除选项可以轻松卸载配置：

```bash
# 取消链接 Neovim 配置
stow -D -t ~/.config nvim
```

## 🛠️ 维护

### 更新配置

```bash
cd ~/.dotfiles
git pull
stow -R -t ~/.config nvim zsh  # 重新链接更新的配置
```

### 备份现有配置

在链接新配置之前，建议备份现有配置：

```bash
# 备份 Neovim 配置
mv ~/.config/nvim ~/.config/nvim.backup

# 备份 Zsh 配置
mv ~/.config/zsh ~/.config/zsh.backup
mv ~/.zshenv ~/.zshenv.backup
```

## 📝 依赖项

### macOS
- Homebrew
- Stow (`brew install stow`)

### Ubuntu/Linux
- Stow (`apt install stow`)
- Build Essential (`apt install build-essential`)
- Git, Curl

## 🎯 应用程序 (macOS Brewfile)

Brewfile 包含以下类型的应用：

**命令行工具：**
- fastfetch, fnm, fzf, starship, tree, zellij, zoxide
- zsh-completions, zsh-syntax-highlighting

**GUI 应用：**
- 开发工具：Cursor, Zed, Visual Studio Code, Fork
- 生产力：Raycast, Notion, Obsidian, 1Password
- 通讯：Telegram, WeChat, Microsoft Outlook
- 媒体：IINA, YouTube Music
- 系统工具：AltTab, BetterDisplay, Mac Mouse Fix
- 以及更多...

查看 `brewfile/.Brewfile` 了解完整列表。

## 📄 许可证

个人配置文件，仅供参考。

## 🤝 贡献

这是我的个人配置仓库，但欢迎提出建议和改进意见！

---

**提示：** 在应用配置前，请仔细阅读相关配置文件，确保它们符合你的需求。
