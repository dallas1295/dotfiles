#!/bin/bash
# tmux-workspaces.sh
# Create "term" and "code" tmux sessions if they don't exist,
# then attach to "term".

# "term" session in $HOME
if ! tmux has-session -t term 2>/dev/null; then
    tmux new-session -ds term -c "$HOME"
fi

# "code" session in $HOME/projects
if ! tmux has-session -t code 2>/dev/null; then
    tmux new-session -ds code -c "$HOME/projects"
fi

# Always start in term
tmux attach-session -t term
