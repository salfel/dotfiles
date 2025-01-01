#!/usr/bin/env bash

path=$(find ~/Code -maxdepth 3 -type d -name .git | sed 's/\/.git//' | fzf)

if [[ -z $path ]]; then
    exit 0
fi

name=$(basename $path)

if tmux has-session -t=$name 2> /dev/null; then
    tmux attach -t $name
    exit 0
fi

tmux new-session -d -s $name -c $path

# Window 1: Editor
tmux rename-window -t $name:1 'editor'
tmux send-keys -t $name:1 'nvim' C-m

# Window 2: Git
tmux new-window -t $name:2 -n 'git' -c $path
tmux send-keys -t $name:2 'lazygit' C-m

# Window 3: Terminal
tmux new-window -t $name:3 -n 'terminal' -c $path

if [ $name = 'dotfiles' ]; then
    tmux new-window -t $name:4 -n 'btop' -c $path
    tmux send-keys -t $name:4 'btop' C-m
fi

# Select first window and attach to session
tmux select-window -t $name:1

if [[ -z $TMUX ]]; then
    tmux attach-session -t $name
else 
    tmux switch-client -t $name
fi
