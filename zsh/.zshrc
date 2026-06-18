# Vi key bindings
bindkey -v

# Exports
export SUDOEDITOR=nvim
export EDITOR=nvim
export VISUAL=$EDITOR
export TERMINAL=foot
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
export PYENV_ROOT="$HOME/.pyenv"
export XDG_CURRENT_DESKTOP=sway

# PATH
typeset -U path
path=(
  "$HOME/.local/bin"
  "$(go env GOPATH)/bin"
  "$HOME/.cargo/bin"
  "$PYENV_ROOT/bin"
  "$HOME/.opencode/bin"
  "$HOME/opt/bin"
  $path
)

# Rustup
source "$HOME/.cargo/env" 2>/dev/null

# Aliases
alias hx=helix
alias svim='sudo -E nvim'

# alias pacman=paru
#
alias poweroff='loginctl poweroff'
alias reboot='loginctl reboot'
alias xi='sudo xbps-install'
alias xr='sudo xbps-remove'
alias xq='sudo xbps-query'
alias xu='sudo xbps-install -Su'
alias vsv='sudo vsv'

alias ls=lsd
alias ll='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree --depth 2'
alias lg='lsd -la --git'

# FZF
export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Inits
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Completions (zsh-completions)
fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (must be last)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

clear
