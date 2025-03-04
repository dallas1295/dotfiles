if [[ -z "$TMUX" ]] && [[ "$TERM" != "linux" ]] && [[ -z "$SSH_CONNECTION" ]]; then
  tmux attach -t default || tmux new -s default
fi

sleep 0.5
fastfetch

export PATH=$HOME/.local/bin:$PATH
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
