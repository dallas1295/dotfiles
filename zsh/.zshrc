# if [[ -z "$TMUX" ]]; then
#     exec tmux new-session -A -s Main
# fi

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -Uz compinit && compinit

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

alias svim='sudo -E nvim'

alias poweroff='loginctl poweroff'
alias reboot='loginctl reboot'
alias xi='sudo xbps-install'
alias xr='sudo xbps-remove'
alias xq='sudo xbps-query -Rs'
alias xu='sudo xbps-install -Su'
alias vsv='sudo vsv'
alias mu='~/thirdparty/data/mullvad/mullvad_up.sh'
alias md='~/thirdparty/data/mullvad/mullvad_down.sh'

mullvad-widget() { ~/thirdparty/data/mullvad/mullvad_up.sh; zle reset-prompt; }
zle -N mullvad-widget
bindkey '^Xm' mullvad-widget

alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree --depth 2'
alias lg='lsd -la --git'

export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

clear

