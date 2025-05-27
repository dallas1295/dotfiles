# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/dallas/.zsh/completions:"* ]]; then export FPATH="/home/dallas/.zsh/completions:$FPATH"; fi
# tmux rules
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
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion)

# environment calls
export EDITOR='nvim'
export TERM='wezterm'
export PATH=$HOME/.local/bin:$PATH

# for fedora alias dnf='sudo dnf'
# for arch
alias yay='paru'

alias vi='nvim'

# git setup
alias gs='git status --short'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl='git log'
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
. "/home/dallas/.deno/env"
# Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit
