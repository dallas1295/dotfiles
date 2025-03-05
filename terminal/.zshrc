if [[ -z "$TMUX" ]] && [[ "$TERM" != "linux" ]] && [[ -z "$SSH_CONNECTION" ]]; then
  if tmux attach -t Main 2>/dev/null; then
    :
  elif tmux new-session -d -s Main 2>/dev/null; then
    tmux attach -t Main
  else
    tmux source-file ~/.tmux.conf
  fi
fi

sleep 0.5
fastfetch

export EDITOR='neovim'
export PATH=$HOME/.local/bin:$PATH
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
