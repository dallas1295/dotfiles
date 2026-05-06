# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/dallas/.zsh/completions:"* ]]; then export FPATH="/home/dallas/.zsh/completions:$FPATH"; fi
# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/dallas/.zsh/completions:"* ]]; then
  export FPATH="/home/dallas/.zsh/completions:$FPATH"
fi

# if command -v tmux >/dev/null 2>&1; then
#   # Only run if not already in tmux
#   if [[ -z "$TMUX" ]]; then
#     exec tmux
#       fi
# fi

bindkey -v

# zsh-completions
fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit

# zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion)

# environment calls
# export EDITOR="nvim"
# export SUDOEDITOR="nvim"
export SUDOEDITOR="nvim"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export TERMINAL='ghostty'
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$HOME/.cargo/bin:$PATH"

# alias vi='nvim'
alias notes='cd ~/vaults/stuff/ && nvim'
alias hx='helix'
alias em='emacs'
alias et='emacs -nw'


# ls shows hidden files & colorize
alias ls='lsd'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree --depth 2'
alias lg='ls -la --git'

alias sm='ncpamixer -t o'

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# opencode
export PATH="/home/dallas/.opencode/bin:$PATH"

clear
fastfetch
export BROWSER=brave-browser

llm() {
  local models_dir="$HOME/models"
  local port="${LLM_PORT:-18881}"
  local ctx="${LLM_CTX:-16384}"

  if [ "$1" = "stop" ]; then
    pkill -f "llama-server" 2>/dev/null && echo "Server stopped." || echo "No server running."
    return 0
  fi

  if [ -z "$1" ]; then
    echo "Usage: llm <model>"
    echo "       llm stop"
    echo ""
    echo "Available models:"
    ls "$models_dir"/*.gguf 2>/dev/null | while read f; do
      echo "  $(basename "$f" .gguf)"
    done
    return 1
  fi

  local model="$models_dir/$1.gguf"
  if [ ! -f "$model" ]; then
    echo "Model not found: $model"
    return 1
  fi

  pkill -f "llama-server" 2>/dev/null
  sleep 1
  echo "Starting $1 on port $port (ctx=$ctx)..."
  llama-server -m "$model" -c "$ctx" -np 1 --port "$port"
}
