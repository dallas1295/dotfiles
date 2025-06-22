# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/dallas/.zsh/completions:"* ]]; then
  export FPATH="/Users/dallas/.zsh/completions:$FPATH"
fi

# Only run tmux auto-attach if not already in tmux
if [[ -z "$TMUX" ]] && [[ "$TERM" != "linux" ]] && [[ -z "$SSH_CONNECTION" ]]; then
  if tmux attach -t Main 2>/dev/null; then
    :
  elif tmux new-session -d -s Main 2>/dev/null; then
    tmux attach -t Main
  else
    tmux source-file ~/.tmux.conf
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
export EDITOR='nvim'
export TERMINAL='ghostty'
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:$(go env GOPATH)/bin"

alias vi='nvim'

# ls shows hidden files
alias ls='ls -a'

# git setup
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl='git log'
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/kanagawa-clean.omp.json)"
eval "$(zoxide init zsh)"

. "/Users/dallas/.deno/env"
