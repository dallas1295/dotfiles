set -g fish_key_bindings fish_vi_key_bindings
set -gx SUDOEDITOR emacs
set -gx EDITOR emacs
set -gx VISUAL $EDITOR
set -gx TERMINAL ghostty
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/config"
set -gx PYENV_ROOT "$HOME/.pyenv"


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

alias pacman 'paru'

alias ls lsd
alias ll 'lsd -l'
alias la 'lsd -a'
alias lla 'lsd -la'
alias lt 'lsd --tree --depth 2'
alias lg 'lsd -la --git'

alias sm 'ncpamixer -t o'

alias ai 'llama-server --models-dir ~/models/ -ngl 30 -t 10 --ctx-size 128000 --port 42069 --models-max 1 --host 0.0.0.0 --sleep-idle-seconds 10'

zoxide init fish | source
# starship init fish | source

clear
# fastfetch
