if [[ -z "$TMUX" ]] && [[ "$TERM" != "linux" ]] && [[ -z "$SSH_CONNECTION" ]]; then
  if tmux attach -t default 2>/dev/null; then
    tmux new-window # Create a new window (tab)
  else
    tmux source-file ~/.tmux.conf #Source the config.
  fi
fi

sleep 0.5
fastfetch

export EDITOR='neovim'
export PATH=$HOME/.local/bin:$PATH
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
