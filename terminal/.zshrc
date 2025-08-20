# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/dallas/.zsh/completions:"* ]]; then
  export FPATH="/Users/dallas/.zsh/completions:$FPATH"
fi

# Auto-launch tmux
if [[ -z "$TMUX" ]] && [[ -n "$PS1" ]] && [[ "$(uname)" != "Darwin" || "$TERM_PROGRAM" != "Apple_Terminal" ]]; then
    tmux attach -t default 2>/dev/null || tmux new-session -s default
fi

bindkey -v

# zsh-completions
fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion)

# environment calls
export EDITOR='nvim'
export TERMINAL='ghostty'
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"

alias vi='nvim'

alias notes='nvim ~/Library/Mobile\ Documents/com~apple~CloudDocs/vaults/notes'

# ls shows hidden files & colorize
alias ls='ls -aG'

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/gruvvy.omp.json)"
eval "$(zoxide init zsh)"

. "/Users/dallas/.deno/env"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
