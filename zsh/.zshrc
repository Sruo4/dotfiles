eval "$(starship init zsh)"

export TERM=xterm-256color

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# zoxide：智能 cd
eval "$(zoxide init zsh)"

# fnm：Node 版本管理
eval "$(fnm env)"

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

############################################
#  3. 自定义别名 & 快捷命令
############################################
# 交互式 brew upgrade 别名
alias brewup='brew outdated --greedy | fzf -m --reverse | awk '"'"'{print $1}'"'"' | xargs brew upgrade'

alias ff='fastfetch'

# BSD Color
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
alias ll='ls -lAhF'
