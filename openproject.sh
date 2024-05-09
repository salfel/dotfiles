#!/bin/bash

stack=$1
project=$2

if [ -z "$stack" ]; then
    echo "Please provide the stack name"
    exit 1
fi

if [ -z "$project" ]; then
    echo "Please provide the project name"
    exit 1
fi

if ! [ -d ~/Code/$project ]; then
    echo "Project does not exist"
    exit 1
fi

if [ $stack = "laravel" ]; then
    tmux new-session -d -s $project
    tmux send-keys -t $project:1 'cd ~/Code/'$project C-m
    tmux send-keys -t $project:1 'nvim' C-m
    tmux new-window
    tmux send-keys -t $project:2 'cd ~/Code/'$1 C-m
    tmux send-keys -t $project:2 'artisan octane:start --watch' C-m
    tmux split-window -v -t $project:2
    tmux send-keys -t $project:2 'cd ~/Code/'$project C-m
    tmux send-keys -t $project:2 'bun run dev' C-m
    tmux new-window
    tmux send-keys -t $project:3 'cd ~/Code/'$project C-m

    tmux attach-session -t $project:1
elif [ $stack = "astro" ]; then
    tmux new-session -d -s $project
    tmux send-keys -t $project:1 'cd ~/Code/'$project C-m
    tmux send-keys -t $project:1 'nvim' C-m
    tmux new-window
    tmux send-keys -t $project:2 'cd ~/Code/'$project C-m
    tmux send-keys -t $project:2 'bun run dev' C-m
    tmux split-window -v -t $project:2
    tmux send-keys -t $project:2 'cd ~/Code/'$project C-m

    tmux attach-session -t $project:1
fi
