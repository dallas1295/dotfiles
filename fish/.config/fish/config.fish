set -g fish_key_bindings fish_vi_key_bindings
set -gx SUDOEDITOR nvim
set -gx EDITOR nvim 
set -gx VISUAL $EDITOR
set -gx TERMINAL foot
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/config"
set -gx PYENV_ROOT "$HOME/.pyenv"
set -Ux XDG_CURRENT_DESKTOP sway


fish_add_path "$HOME/.local/bin"
fish_add_path (go env GOPATH)/bin
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$PYENV_ROOT/bin"
fish_add_path "$HOME/.opencode/bin"

for dir in (find "$HOME/opt" -mindepth 1 -maxdepth 3 -type d)
    fish_add_path "$dir"
end

alias notes 'cd ~/vaults/stuff/ && nvim'
alias hx helix
alias svim 'sudo -E nvim'

alias pacman 'paru'

# alias poweroff 'loginctl poweroff'
# alias reboot 'loginctl reboot'
# alias xi 'sudo xbps-install'
# alias xr 'sudo xbps-remove'
# alias xq 'sudo xbps-query'
# alias xu 'sudo xbps-install -Su'

alias ls lsd
alias ll 'lsd -l'
alias la 'lsd -a'
alias lla 'lsd -la'
alias lt 'lsd --tree --depth 2'
alias lg 'lsd -la --git'

alias mv 'mullvad-tui'

set -gx FZF_DEFAULT_COMMAND "fd --hidden --exclude .git --type f"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

zoxide init fish | source
# starship init fish | source

clear
# fastfetch
