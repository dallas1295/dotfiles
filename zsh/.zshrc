# if [[ -z "$TMUX" ]]; then
#     exec tmux new-session -A -s Main
# fi
#
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

alias uu='~/thirdparty/bin/uu.sh'

alias ls='ls -A --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -lA'
alias lt='ls --tree --depth 2 --color=auto'
alias lg='ls -la --git --color=auto'

export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

clear

