#!/usr/bin/env bash

set -e

# --- Checkpoint 机制 ---
CHECKPOINT_FILE="$HOME/.setup_ubuntu_checkpoint"
touch "$CHECKPOINT_FILE"

step_done() {
    grep -qxF "$1" "$CHECKPOINT_FILE" 2>/dev/null
}

mark_done() {
    echo "$1" >> "$CHECKPOINT_FILE"
}

# 交互式步骤执行器
# 用法: run_step <step_id> <description> <function>
run_step() {
    local step_id="$1"
    local desc="$2"
    local func="$3"

    if step_done "$step_id"; then
        echo "⏭️  [$step_id] $desc — 已完成，跳过"
        return 0
    fi

    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📦 [$step_id] $desc"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    read -rp "执行此步骤？[Y/n/q] " answer
    case "${answer,,}" in
        n)
            echo "⏭️  已跳过。"
            return 0
            ;;
        q)
            echo "👋 已退出安装。下次运行将从此处继续。"
            exit 0
            ;;
        *)
            "$func"
            mark_done "$step_id"
            echo "✅ [$step_id] 完成。"
            ;;
    esac
}

# --- 各步骤定义 ---

step_apt_base() {
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y build-essential git curl software-properties-common stow zsh
}

step_starship() {
    curl -sS https://starship.rs/install.sh | sh -s -- -y
}

step_neovim() {
    sudo apt install -y ripgrep unzip xclip

    local arch
    case "$(uname -m)" in
        aarch64|arm64) arch="arm64" ;;
        *)             arch="x86_64" ;;
    esac

    echo "I> 正在从 GitHub 下载最新稳定版 Neovim (${arch})..."
    curl -LO "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz"
    sudo rm -rf "/opt/nvim-linux-${arch}"
    sudo tar -C /opt -xzf "nvim-linux-${arch}.tar.gz"
    rm "nvim-linux-${arch}.tar.gz"
    sudo ln -sf "/opt/nvim-linux-${arch}/bin/nvim" /usr/local/bin/nvim
}

step_clone_dotfiles() {
    DOTFILES_DIR="$HOME/dotfiles"
    if [ -d "$DOTFILES_DIR" ]; then
        echo "⚠️  发现已存在的 $DOTFILES_DIR 目录，将进行备份并重新克隆..."
        mv "$DOTFILES_DIR" "$DOTFILES_DIR.bak.$(date +%F-%T)"
    fi
    git clone https://github.com/Sruo4/dotfiles.git "$DOTFILES_DIR"
}

step_stow_dotfiles() {
    DOTFILES_DIR="$HOME/dotfiles"
    cd "$DOTFILES_DIR"
    mkdir -p "$HOME/.config"

    echo "I> 正在链接配置到 $HOME..."
    stow -R -t "$HOME" zshenv git nvim starship zellij zsh
}

step_change_shell() {
    if ! grep -q "$(which zsh)" /etc/shells; then
        echo "🚀 将 Zsh 添加到允许的 shells 列表中..."
        which zsh | sudo tee -a /etc/shells
    fi
    chsh -s "$(which zsh)"
}

# --- 执行 ---

echo "🚀 Ubuntu 环境配置脚本"
echo "   每一步都可选择执行(Y)、跳过(n)、退出(q)"
echo "   已完成的步骤会自动跳过（重置：rm $CHECKPOINT_FILE）"

run_step "apt_base"       "更新系统并安装基础依赖"          step_apt_base
run_step "starship"       "安装 Starship 提示符"            step_starship
run_step "neovim"         "安装 Neovim 及依赖 (unstable PPA)" step_neovim
run_step "clone_dotfiles" "克隆 dotfiles 配置仓库"          step_clone_dotfiles
run_step "stow_dotfiles"  "使用 Stow 链接配置文件"          step_stow_dotfiles
run_step "change_shell"   "更改默认 Shell 为 Zsh"           step_change_shell

echo ""
echo "🎉 全部完成！"
echo "请完全退出终端或重启您的 OrbStack 镜像，以使 Zsh 成为您的默认 Shell。"
