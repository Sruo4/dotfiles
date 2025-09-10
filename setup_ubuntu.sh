#!/usr/bin/env bash

# 脚本出错时立即退出
set -e

# --- 1. 系统准备与基础依赖安装 ---
echo "🚀 开始更新系统并安装基础依赖..."
sudo apt update
sudo apt upgrade -y

# 安装后续步骤必需的工具
# build-essential: 包含 make, gcc 等编译工具
# git: 用于克隆您的dotfiles仓库
# curl: 用于下载starship安装脚本
# software-properties-common: 提供 add-apt-repository 命令
sudo apt install -y build-essential git curl software-properties-common

echo "✅ 基础依赖安装完成。"

# --- 2. 安装 Zsh 和 Starship ---
echo "🚀 正在安装 Zsh..."
sudo apt install -y zsh
echo "✅ Zsh 安装完成。"

echo "🚀 正在安装 Starship..."
# 使用 -y 参数使其在脚本中非交互式运行
curl -sS https://starship.rs/install.sh | sh -s -- -y
echo "✅ Starship 安装完成。"


# --- 3. 安装 Neovim 及其依赖 ---
echo "🚀 正在添加 Neovim (unstable) PPA..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y

echo "🚀 正在更新软件源并安装 Neovim 及其依赖..."
sudo apt update
# ripgrep, unzip, xclip 是常见的nvim插件依赖
# neovim 本体
sudo apt install -y ripgrep unzip xclip neovim
echo "✅ Neovim 安装完成。"


# --- 4. 克隆 dotfiles 配置仓库 ---
# 将您的配置文件克隆到家目录下的一个隐藏文件夹中，这是常见的做法
echo "🚀 正在从 GitHub 克隆您的 dotfiles..."
# 如果 ~/.dotfiles 目录已存在，先移除，避免 git clone 失败
if [ -d "$HOME/.dotfiles" ]; then
    echo "⚠️  发现已存在的 ~/.dotfiles 目录，将进行备份并重新克隆..."
    mv "$HOME/.dotfiles" "$HOME/.dotfiles.bak.$(date +%F-%T)"
fi
git clone https://github.com/Sruo4/dotfiles.git "$HOME/.dotfiles"
echo "✅ Dotfiles 已克隆至 ~/.dotfiles"


# --- 5. 应用配置 ---
echo "🚀 正在配置 Zsh 和 Starship..."
# 将 starship 的初始化命令添加到 .zshrc 的末尾
# 如果文件不存在，这行命令会自动创建它
echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
echo "✅ Starship 已配置到 .zshrc。"

# --- 注意：应用您自己的 dotfiles ---
# 您的 dotfiles 仓库可能需要一个安装脚本或手动创建符号链接 (symlink)
# 例如: ln -s ~/.dotfiles/nvim ~/.config/nvim
# 这一步需要您根据自己的仓库结构来决定，因此脚本中未包含具体操作。
echo "🔔 请注意：脚本已完成软件安装和基础配置。"
echo "接下来，您需要手动进入 ~/.dotfiles 目录，并按照您自己的方式来应用这些配置（例如，运行安装脚本或创建符号链接）。"


# --- 6. 更改默认 Shell 为 Zsh ---
# 检查 Zsh 是否已在 /etc/shells 中
if ! grep -q "$(which zsh)" /etc/shells; then
  echo "🚀 将 Zsh 添加到允许的 shells 列表中..."
  which zsh | sudo tee -a /etc/shells
fi

echo "🚀 正在将默认 Shell 更改为 Zsh..."
# 这条命令会提示您输入密码
chsh -s "$(which zsh)"
echo "✅ 默认 Shell 已设置为 Zsh。"


# --- 完成 ---
echo "🎉 全部完成！"
echo "请完全退出终端或重启您的计算机，以使 Zsh 成为您的默认 Shell。"
