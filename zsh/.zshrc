# ~/.zshrc: Unified, Secure Configuration for macOS (Homebrew) and Linux (apt)

# ------------------------------------------------------------------------------
# 1. 环境变量 & 私密配置 (Environment Variables & Secrets)
# ------------------------------------------------------------------------------

# 为现代终端设置256色支持
export TERM=xterm-256color

# ------------------------------------------------------------------------------
# 2. Zsh 补全系统 (Completion System)
# ------------------------------------------------------------------------------

# 如果 Homebrew 存在，将其补全路径添加到 FPATH (主要用于 macOS)
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi

# 初始化 Zsh 自动补全系统
autoload -Uz compinit
compinit -i

# ------------------------------------------------------------------------------
# 3. 工具初始化 (Tool Initializations)
# ------------------------------------------------------------------------------

# zoxide: 更智能的 cd 命令
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# fnm: Fast Node Manager
if type fnm &>/dev/null; then
  # --use-on-cd 会在进入项目目录时自动切换 Node 版本
  eval "$(fnm env --use-on-cd)"
fi

# ------------------------------------------------------------------------------
# 插件管理 (zsh_unplugged)
# ------------------------------------------------------------------------------
# 插件存储目录（遵循 XDG 规范）
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# 克隆并加载 zsh_unplugged（首次运行时自动下载）
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

# 插件列表
repos=(
  # 语法高亮
  'zsh-users/zsh-syntax-highlighting'
  # 自动建议
  'zsh-users/zsh-autosuggestions'
  # 历史搜索（可选，与你现有配置兼容）
  'zsh-users/zsh-history-substring-search'
  # 其他你需要的插件（例如：fzf 集成、目录跳转增强等）
  'Aloxaf/fzf-tab'  # 补全界面美化
  "jeffreytse/zsh-vi-mode"
)

# 加载所有插件
plugin-load $repos

# Starship: 跨平台的终端提示符
if type starship &>/dev/null; then
  eval "$(starship init zsh)"
fi



# kiro: Kiro 终端集成
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# ------------------------------------------------------------------------------
# 4. 自定义别名 & 函数 (Aliases & Functions)
# ------------------------------------------------------------------------------

# fastfetch: 系统信息速览
if type fastfetch &>/dev/null; then
  alias ff='fastfetch'
fi

# brewup: 交互式 brew upgrade (只有当 brew 命令存在时才会定义)
if type brew &>/dev/null; then
  alias brewup='brew outdated --greedy | fzf -m --reverse | awk '"'"'{print $1}'"'"' | xargs brew upgrade'
fi

if type eza &>/dev/null; then
  alias tree='eza -T'
fi

# 加载本地配置（如果有）
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# 'ls' 命令的平台适配别名和颜色
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

