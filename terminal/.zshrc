if [[ -z "$TMUX" ]] && [[ "$TERM" != "linux" ]] && [[ -z "$SSH_CONNECTION" ]]; then
  if tmux attach -t default 2>/dev/null; then
    tmux new-window # Create a new window (tab)
  else
    tmux new-session -d -s default #Create Detached session.
    tmux source-file ~/.tmux/tmux.conf #Source the config.
    tmux attach-session -t default #Attach to the session.
  fi
fi

sleep 0.5
fastfetch

export EDITOR='nvim'
export PATH=$HOME/.local/bin:$PATH
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
