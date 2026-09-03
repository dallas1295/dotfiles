if [[ -z "$TMUX" ]]; then
    exec tmux new-session -A -s Main
fi

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions.zsh

autoload -Uz compinit && compinit

command -v fzf >/dev/null 2>&1 && eval "$(fzf --zsh)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

alias svim='sudo -E nvim'

alias poweroff='loginctl poweroff'
alias reboot='loginctl reboot'
alias xi='sudo xbps-install'
alias xr='sudo xbps-remove'
alias xq='sudo xbps-query -Rs'
alias xu='sudo xbps-install -Su'
alias vsv='sudo vsv'

alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree --depth 2'
alias lg='lsd -la --git'

export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

eval "$(starship init zsh)"
clear

