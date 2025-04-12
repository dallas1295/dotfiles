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

# zsh-completions
fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit
# zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# environment calls
export EDITOR='nvim'
export PATH=$HOME/.local/bin:$PATH


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
