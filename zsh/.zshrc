# ~/.zshrc: Unified, Secure Configuration for macOS (Homebrew) and Linux (apt)

# ------------------------------------------------------------------------------
# 1. 环境变量 & 私密配置 (Environment Variables & Secrets)
# ------------------------------------------------------------------------------

# 为现代终端设置256色支持
export TERM=xterm-256color

# 加载私密配置（API密钥等敏感信息）
# 建议将敏感信息放在~/.zshrc.local，避免提交到版本控制
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi


# ==============================================================
# 2. Zsh核心功能配置 (Zsh Core Configuration)
# ==============================================================

# 如果 Homebrew 存在，将其补全路径添加到 FPATH (主要用于 macOS)
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi

# 初始化 Zsh 自动补全系统
autoload -Uz compinit
compinit -i


# ==============================================================
# 3. 插件管理 (Plugin Management via zsh_unplugged)
# ==============================================================

# 插件存储目录（遵循XDG规范）
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# 克隆并加载 zsh_unplugged（首次运行时自动下载）
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

# 插件列表
repos=(
  zsh-users/zsh-syntax-highlighting  # 语法高亮
  zsh-users/zsh-autosuggestions      # 命令自动建议
  zsh-users/zsh-history-substring-search  # 历史命令搜索
  Aloxaf/fzf-tab                     # 补全界面美化
  jeffreytse/zsh-vi-mode             # Vi模式支持
)

# 加载所有插件
plugin-load $repos


# ==============================================================
# 4. 工具初始化与集成 (Tool Initializations & Integrations)
# ==============================================================

# zoxide: 增强型cd命令，提供智能目录跳转
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# fnm: Node版本管理器，进入目录时自动切换Node版本
if type fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd)"
fi

# Starship: 跨平台终端提示符美化工具
if type starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ==============================================================
# 5. 自定义别名与函数 (Custom Aliases & Functions)
# ==============================================================

# 系统信息展示
if type fastfetch &>/dev/null; then
  alias ff='fastfetch'
fi


# 目录树展示 (eza替代传统tree)
if type eza &>/dev/null; then
  alias tree='eza -T'
fi

# ls命令平台适配 (带颜色支持)
case "$(uname -s)" in
  Darwin) # macOS
    export CLICOLOR=1
    export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
    alias ls='ls -G'
    alias ll='ls -lAhF'
    ;;
  Linux) # WSL2, OrbStack, etc.
    alias ls='ls --color=auto'
    alias ll='ls -alhF --color=auto'
    ;;
esac

# 清屏命令 (更彻底的清屏)
alias cls="printf \"\033[3J\033[H\033[2J\""

