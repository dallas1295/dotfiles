set -g fish_greeting
set -g fish_key_bindings fish_vi_key_bindings
set -gx SUDOEDITOR nvim
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx TERMINAL foot
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/thirdparty/bin"

alias svim 'sudo -E nvim'

# alias pacman 'sudo pacman'

alias poweroff 'loginctl poweroff'
alias reboot 'loginctl reboot'
alias xi 'sudo xbps-install'
alias xr 'sudo xbps-remove'
alias xq 'sudo xbps-query -Rs'
alias xu 'sudo xbps-install -Su'
alias vsv 'sudo vsv'

alias ls lsd
alias ll 'lsd -l'
alias la 'lsd -a'
alias lla 'lsd -la'
alias lt 'lsd --tree --depth 2'
alias lg 'lsd -la --git'

set -gx FZF_DEFAULT_COMMAND "fd --hidden --exclude .git --type f"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

zoxide init fish | source

clear
# fastfetch


if status is-interactive
    and not set -q TMUX
    exec tmux new-session -A -s Main
end

