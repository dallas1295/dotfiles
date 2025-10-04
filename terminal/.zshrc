# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/dallas/.zsh/completions:"* ]]; then export FPATH="/Users/dallas/.zsh/completions:$FPATH"; fi
# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/dallas/.zsh/completions:"* ]]; then
  export FPATH="/Users/dallas/.zsh/completions:$FPATH"
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
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion)

# environment calls
export EDITOR="hx"
export VISUAL="$EDITOR"   # Many programs look at VISUAL first
export TERMINAL='ghostty'
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$(brew --prefix ruby)/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.gem/ruby/$(ruby -e 'print RUBY_VERSION')/bin:$PATH"

alias vi='nvim'

# ls shows hidden files & colorize

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree --depth 2'
alias lg='ls -la --git'

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/gruvvy.omp.json)"
eval "$(zoxide init zsh)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# bun completions
[ -s "/Users/dallas/.bun/_bun" ] && source "/Users/dallas/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/Users/dallas/.opencode/bin:$PATH
