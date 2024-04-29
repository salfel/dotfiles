#!/bin/bash

if [ -z "$1" ]; then
    echo "Please provide the project name"
    exit 1
fi

tmux new-session -d -s $1
tmux send-keys -t $1:1 'cd ~/Code/'$1 C-m
tmux send-keys -t $1:1 'nvim' C-m
tmux new-window
tmux send-keys -t $1:2 'cd ~/Code/'$1 C-m
tmux send-keys -t $1:2 'artisan octane:start --watch' C-m
tmux split-window -v -t $1:2
tmux send-keys -t $1:2 'cd ~/Code/'$1 C-m
tmux send-keys -t $1:2 'bun run dev' C-m
tmux new-window
tmux send-keys -t $1:3 'cd ~/Code/'$1 C-m

tmux attach-session -t $1:1
