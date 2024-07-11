#!/usr/bin/env bash

session_name=obsidian
vault_dir=~/Obsidian
session_cmd='nvim Welcome.md +ObsidianToday +bdelete Welcome.md'
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $session_name -c $vault_dir $session_cmd
    exit 0
fi

if ! tmux has-session -t=$session_name 2> /dev/null; then
    tmux new-session -ds $session_name -c $vault_dir $session_cmd
fi

if [[ -n $TMUX ]] && [[ -n $tmux_running ]]; then
    tmux switch-client -t $session_name
    exit 0
fi

tmux attach -t $session_name
