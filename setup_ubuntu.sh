#!/usr/bin/env bash

# 脚本出错时立即退出
set -e

# --- 1. 系统准备与基础依赖安装 ---
echo "🚀 开始更新系统并安装基础依赖..."
sudo apt update
sudo apt upgrade -y

# build-essential: 编译工具
# git: 克隆dotfiles
# curl: 下载starship
# software-properties-common: add-apt-repository
# stow: 链接 dotfiles (你的核心工具)
# zsh: 你的目标 shell
sudo apt install -y build-essential git curl software-properties-common stow zsh

echo "✅ 基础依赖安装完成。"

# --- 2. 安装 Starship ---
echo "🚀 正在安装 Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y
echo "✅ Starship 安装完成。"


# --- 3. 安装 Neovim 及其依赖 ---
echo "🚀 正在添加 Neovim (unstable) PPA..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y

echo "🚀 正在更新软件源并安装 Neovim 及其依赖..."
sudo apt update
sudo apt install -y ripgrep unzip xclip neovim
echo "✅ Neovim 安装完成。"


# --- 4. 克隆 dotfiles 配置仓库 ---
# 使用你脚本中的路径
DOTFILES_DIR="$HOME/.dotfiles"

echo "🚀 正在从 GitHub 克隆您的 dotfiles..."
if [ -d "$DOTFILES_DIR" ]; then
    echo "⚠️  发现已存在的 $DOTFILES_DIR 目录，将进行备份并重新克隆..."
    mv "$DOTFILES_DIR" "$DOTFILES_DIR.bak.$(date +%F-%T)"
fi
git clone https://github.com/Sruo4/dotfiles.git "$DOTFILES_DIR"
echo "✅ Dotfiles 已克隆至 $DOTFILES_DIR"


# --- 5. 【关键】使用 Stow 自动链接配置 ---
echo "🚀 正在使用 stow 自动链接您的 XDG 配置..."

# 切换到 dotfiles 目录，这是 stow 运行的上下文
cd "$DOTFILES_DIR"

# 确保 XDG 规范的 .config 目录存在
mkdir -p "$HOME/.config"

# 1. 链接根目录文件 (如 .zshenv)
#    -t $HOME: 目标目录是家目录
#    这会链接: $DOTFILES_DIR/zshenv/.zshenv -> $HOME/.zshenv
echo "I> 正在链接 'zshenv'到 $HOME..."
stow -R -t "$HOME" zshenv

# 2. 链接 XDG 配置
#    -t $HOME/.config: 目标目录是 .config
#    这会链接: $DOTFILES_DIR/nvim -> $HOME/.config/nvim
#             $DOTFILES_DIR/zsh  -> $HOME/.config/zsh
#             ...等等
echo "I> 正在链接 XDG 配置到 $HOME/.config..."
# (我们跳过了 mac 专属的 aerospace, brewfile, hammerspoon)
stow -R -t "$HOME/.config" git nvim starship zellij zsh

echo "✅ Dotfiles 链接完成。"


# --- 6. 更改默认 Shell 为 Zsh ---
if ! grep -q "$(which zsh)" /etc/shells; then
  echo "🚀 将 Zsh 添加到允许的 shells 列表中..."
  which zsh | sudo tee -a /etc/shells
fi

echo "🚀 正在将默认 Shell 更改为 Zsh..."
chsh -s "$(which zsh)"
echo "✅ 默认 Shell 已设置为 Zsh。"


# --- 完成 ---
echo "🎉 全部完成！"
echo "请完全退出终端或重启您的 OrbStack 镜像，以使 Zsh 成为您的默认 Shell。"