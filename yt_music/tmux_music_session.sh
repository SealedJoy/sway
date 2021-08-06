#!/usr/bin/env bash
DISPLAY=:0
tmux set -w status off
tmux splitw "playerctl --follow metadata xesam:title"
tmux splitw "cava"
tmux resize-pane -t Music:1.2 -y 1
tmux splitw "ytfzf -m -s --sort -A -a"
sleep 0.1
tmux resize-pane -t Music:1.3 -y 29
tmux resize-pane -t Music:1.4 -y 1
tmux resize-pane -t Music:1.2 -y 1
tmux resize-pane -t Music:1.1 -y 1
tmux resize-pane -t Music:1.3 -y 25
tmux select-pane -t Music:1.4
