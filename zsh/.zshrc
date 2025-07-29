# ~/.zshrc: Unified, Secure Configuration for macOS (Homebrew) and Linux (apt)

# ------------------------------------------------------------------------------
# 1. 环境变量 & 私密配置 (Environment Variables & Secrets)
# ------------------------------------------------------------------------------

# 为现代终端设置256色支持
export TERM=xterm-256color

# 从一个独立、安全的文件加载私密环境变量 (如 API Keys)
# 确保 ~/.zshrc.secrets 文件不被 Git 等版本控制工具追踪！
if [[ -f ~/.zshrc.secrets ]]; then
  source ~/.zshrc.secrets
fi

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

# Starship: 跨平台的终端提示符
if type starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# zoxide: 更智能的 cd 命令
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# fnm: Fast Node Manager
if type fnm &>/dev/null; then
  # --use-on-cd 会在进入项目目录时自动切换 Node 版本
  eval "$(fnm env --use-on-cd)"
fi

# zsh-syntax-highlighting: 命令语法高亮
ZSH_SYNTAX_HIGHLIGHT_SCRIPT=""
case "$(uname -s)" in
  Darwin)
    # macOS: 使用 brew --prefix 动态查找路径，自动兼容 Apple Silicon/Intel
    if type brew &>/dev/null; then
      local highlight_path
      highlight_path="$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
      if [[ -f "$highlight_path" ]]; then
          ZSH_SYNTAX_HIGHLIGHT_SCRIPT="$highlight_path"
      fi
    fi
    ;;
  Linux)
    # Linux: 通过 apt 等包管理器安装的标准路径
    if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
      ZSH_SYNTAX_HIGHLIGHT_SCRIPT="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    fi
    ;;
esac


if [[ -n "$ZSH_SYNTAX_HIGHLIGHT_SCRIPT" ]]; then
  source "$ZSH_SYNTAX_HIGHLIGHT_SCRIPT"
  unset ZSH_SYNTAX_HIGHLIGHT_SCRIPT # 使用后立即清理，只保留这一处
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

