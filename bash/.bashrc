PS1='\[\e[1;32m\]\u\[\e[0m\]@ \[\e[36m\]\w\[\e[0m\] \$ '

eval "$(fzf --bash)"
eval "$(zoxide init bash)"

PATH="$PATH:$HOME/thirdparty/bin"
PATH="$PATH:$HOME/opt/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/go/bin"
PATH="$PATH:$HOME/.opencode/bin"

alias svim='sudo -E nvim'

alias poweroff='loginctl poweroff'
alias reboot='loginctl reboot'
alias xi='sudo xbps-install -Sy'
alias xr='sudo xbps-remove'
alias xq='sudo xbps-query -Rs'
alias xu='sudo xbps-install -Su'
alias vsv='sudo vsv'

alias mu='~/thirdparty/data/mullvad/mullvad_up.sh'
alias md='~/thirdparty/data/mullvad/mullvad_down.sh'

alias grep='grep --color=auto'
alias ls='ls -pA --color=auto'
alias ll='ls -plhA --color=auto'
alias hl='rg --passthru'

export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source -- ~/thirdparty/bin/share/blesh/ble.sh

# Use bash-completion, if available, and avoid double-sourcing
[[ $PS1 &&
  ! ${BASH_COMPLETION_VERSINFO:-} &&
  -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion



# Pi
export PATH="$HOME/.local/bin:$PATH"
