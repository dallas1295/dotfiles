set -g fish_greeting
set -g fish_key_bindings fish_vi_key_bindings
set -gx SUDOEDITOR nvim
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx TERMINAL foot
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/config"
set -gx PYENV_ROOT "$HOME/.pyenv"

fish_add_path "$HOME/.local/bin"
fish_add_path (go env GOPATH)/bin
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$PYENV_ROOT/bin"
fish_add_path "$HOME/.opencode/bin"
fish_add_path "$HOME/opt/bin"

alias svim 'sudo -E nvim'

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

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PATH $PATH "$HOME/.zvm/bin"
set -gx PATH $PATH "$ZVM_INSTALL/"

if status is-interactive
    and not set -q ZELLIJ
    exec zellij attach --create prometheous
end
