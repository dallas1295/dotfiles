# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/dallas/.zsh/completions:"* ]]; then export FPATH="/home/dallas/.zsh/completions:$FPATH"; fi
# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/dallas/.zsh/completions:"* ]]; then
  export FPATH="/home/dallas/.zsh/completions:$FPATH"
fi

if command -v tmux >/dev/null 2>&1; then
  # Only run if not already in tmux
  if [[ -z "$TMUX" ]]; then
    exec tmux
      fi
fi

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
export EDITOR="nvim"
export SUDOEDITOR="nvim"
# export EDITOR=hx
export VISUAL="$EDITOR"
export TERMINAL='ghostty'
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$HOME/.cargo/bin:$PATH"

# alias vi='nvim'
# alias hx='helix'

# ls shows hidden files & colorize
alias ls='lsd'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree --depth 2'
alias lg='ls -la --git'

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# opencode
export PATH="/home/dallas/.opencode/bin:$PATH"

clear
fastfetch
