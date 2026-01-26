# ~/.zshrc: Unified, Secure Configuration for macOS (Homebrew) and Linux (apt)

# ------------------------------------------------------------------------------
# 1. 环境变量 & 私密配置 (Environment Variables & Secrets)
# ------------------------------------------------------------------------------

# 为现代终端设置256色支持（不强行覆盖已有 TERM）
export TERM="${TERM:-xterm-256color}"

# Zsh 配置目录（优先遵循 ZDOTDIR；否则按 XDG 默认）
ZSH_DOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# 加载私密配置（API密钥等敏感信息）
# 建议将敏感信息放在~/.zshrc.local，避免提交到版本控制
if [[ -f "$ZSH_DOTDIR/.zshrc.local" ]]; then
  source "$ZSH_DOTDIR/.zshrc.local"
fi

# Rust/Cargo 环境配置
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi


# ==============================================================
# 2. Zsh核心功能配置 (Zsh Core Configuration)
# ==============================================================

# 缓存目录 (用于 .zcompdump, .zcompcache 等)
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
if [[ ! -d "$ZSH_CACHE_DIR" ]]; then
  mkdir -p "$ZSH_CACHE_DIR"
fi

# 历史记录文件
ZSH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
if [[ ! -d "$ZSH_DATA_DIR" ]]; then
  mkdir -p "$ZSH_DATA_DIR"
fi
export HISTFILE="${ZSH_DATA_DIR}/history"
if [[ ! -f "$HISTFILE" ]]; then
  : >| "$HISTFILE"
fi
export HISTSIZE=10000
export SAVEHIST=10000

# 3. 补全缓存文件路径
ZCOMPDUMP="${ZSH_CACHE_DIR}/.zcompdump-${ZSH_VERSION}"

# 如果 Homebrew 存在，将其补全路径添加到 FPATH (主要用于 macOS)
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi

# 初始化 Zsh 自动补全系统
autoload -Uz compinit
compinit -i -d "$ZCOMPDUMP"

# 提升函数嵌套层数上限，以兼容复杂的ZLE插件组合 (如starship, zsh-vi-mode等)
export FUNCNEST=1000

# 历史记录配置

setopt HIST_EXPIRE_DUPS_FIRST   # 优先删除重复的旧记录
setopt HIST_IGNORE_DUPS         # 不记录相邻的重复命令
setopt HIST_IGNORE_ALL_DUPS     # 删除历史中所有重复的命令
setopt HIST_FIND_NO_DUPS        # 搜索历史时，显示最近的唯一条目
setopt HIST_IGNORE_SPACE        # 忽略以空格开头的命令
setopt HIST_SAVE_NO_DUPS        # 保存历史时，不保存重复的命令
setopt APPEND_HISTORY           # 立即追加历史，而不是在shell退出时
setopt SHARE_HISTORY            # 在所有打开的终端间共享历史

# 启用交互式注释功能，方便粘贴带注释的命令
setopt INTERACTIVE_COMMENTS


# ==============================================================
# 3. 插件管理 (Plugin Management via zsh_unplugged)
# ==============================================================

# 插件存储目录（遵循XDG规范）
ZPLUGINDIR=${ZPLUGINDIR:-${ZSH_DOTDIR}/plugins}

# 克隆并加载 zsh_unplugged（首次运行时自动下载）
if [[ ! -d "$ZPLUGINDIR/zsh_unplugged" ]]; then
  if command -v git &>/dev/null; then
    command git clone --quiet https://github.com/mattmc3/zsh_unplugged "$ZPLUGINDIR/zsh_unplugged" 2>/dev/null || true
  fi
fi
if [[ -f "$ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh" ]]; then
  source "$ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh"

  # 插件列表
  repos=(
    zsh-users/zsh-autosuggestions      # 命令自动建议
    Aloxaf/fzf-tab                     # 补全界面美化
    jeffreytse/zsh-vi-mode             # Vi模式支持
    akash329d/zsh-alias-finder
    zsh-users/zsh-history-substring-search  # 历史命令搜索
    zsh-users/zsh-syntax-highlighting  # 语法高亮
  )

  # 加载所有插件
  plugin-load $repos

  plugin-update() {
    command -v git &>/dev/null || return 0
    local plugin_dir="${ZPLUGINDIR:-${ZSH_DOTDIR}/plugins}"
    for d in $plugin_dir/*/.git(/); do
      echo "Updating ${d:h:t}..."
      command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
    done
  }

  # 插件配置
  ZSH_HIGHLIGHT_STYLES[comment]='fg=244'
fi

# ==============================================================
# FZF 官方集成 (Official FZF Integration)
# ==============================================================
if type fzf &>/dev/null; then
  if type brew &>/dev/null; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
  elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
  elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  fi
fi

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

if type thefuck &>/dev/null; then
    eval $(thefuck --alias)
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

# ls 命令现代化 (使用eza)
if type eza &>/dev/null; then
  alias ls='eza --icons --git'
  alias ll='eza --icons --git -la -h --header' # -l: long format, -h: human-readable, --header: show header
  alias la='eza --icons --git -la' # -a: show hidden files
  alias tree='eza -T'
fi

# ls命令平台适配 (带颜色支持)
case "$(uname -s)" in
  Darwin) # macOS
    export CLICOLOR=1
    export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
    ;;
  Linux) # WSL2, OrbStack, etc.
    if ! type eza &>/dev/null; then
      alias ls='ls --color=auto'
      alias ll='ls -alhF --color=auto'
    fi
    ;;
esac

# 清屏命令 (更彻底的清屏)
alias cls="printf \"\033[3J\033[H\033[2J\""

# =============================================================================
# VI-MODE & FZF 终极解决方案 (The Final Solution via precmd hook)
# =============================================================================
_apply_final_vi_fzf_bindings() {
  # --- 绑定 FZF 功能 ---
  # 1. 创建包装器
  fzf_vi_search() { zle fzf-history-widget; }
  zle -N fzf_vi_search

  # 2. 绑定 vicmd (命令模式)下的 / 和 ? 为 FZF 搜索
  bindkey -M vicmd '/' fzf_vi_search
  bindkey -M vicmd '?' fzf_vi_search
  bindkey -M viins '^I' fzf-tab-complete
  bindkey -M vicmd '^I' fzf-tab-complete

  # 3. 绑定 viins (插入模式)下的 Ctrl-R 为 FZF 搜索
  bindkey -M viins '^R' fzf-history-widget

  # --- 恢复 Vi 原生功能 ---
  # 4. 绑定 vicmd (命令模式)下的 Ctrl-R 为 redo
  #    根据 `zle -l` 的输出，正确的 widget 名称是 `redo`
  bindkey -M vicmd '^R' redo # <--- 这里是唯一的修改！

  # --- 执行一次后自我移除，避免重复执行 ---
  precmd_functions=(${precmd_functions[@]:#_apply_final_vi_fzf_bindings})
}

# 将函数添加到 precmd 钩子数组中，等待 Shell 准备就绪后执行
precmd_functions+=(_apply_final_vi_fzf_bindings)
export EDITOR="nvim"
export VISUAL="nvim"

# ==============================================================
# 6. PATH 与跨平台环境变量 (macOS + Linux)
# ==============================================================

_path_prepend() {
  local dir="$1"
  [[ -n "$dir" && -d "$dir" ]] || return 0
  case ":$PATH:" in
    *":$dir:"*) ;;
    *) export PATH="$dir:$PATH" ;;
  esac
}

export PGSERVICEFILE="$HOME/.config/pg/service.conf"
export PGPASSFILE="$HOME/.config/pg/pgpass"

# Homebrew (macOS only)
if [[ "$(uname -s)" == "Darwin" ]] && type brew &>/dev/null; then
  _path_prepend "$(brew --prefix)/opt/postgresql@15/bin"
  # macOS 自带 /usr/bin/trash；不强行用 Homebrew 版以避免行为差异
fi

export OTEL_EXPORTER_OTLP_ENDPOINT="${OTEL_EXPORTER_OTLP_ENDPOINT:-http://localhost:4318}"

# Homebrew trash（可选）
# 主要用于交互式手动操作：默认用功能更全的 Homebrew 版，并保留系统版入口。
if [[ "$(uname -s)" == "Darwin" ]] && [[ -x "/opt/homebrew/opt/trash/bin/trash" ]]; then
  alias strash="/usr/bin/trash"
  if [[ -o interactive ]]; then
    alias trash="/opt/homebrew/opt/trash/bin/trash"
  fi
fi

# pnpm (macOS: ~/Library/pnpm, Linux: ~/.local/share/pnpm)
if [[ -z "${PNPM_HOME:-}" ]]; then
  if [[ -d "$HOME/Library/pnpm" ]]; then
    export PNPM_HOME="$HOME/Library/pnpm"
  elif [[ -d "$HOME/.local/share/pnpm" ]]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
  fi
fi
if [[ -n "${PNPM_HOME:-}" ]]; then
  _path_prepend "$PNPM_HOME"
fi

# uv
_path_prepend "$HOME/.local/bin"

# bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
_path_prepend "$BUN_INSTALL/bin"
