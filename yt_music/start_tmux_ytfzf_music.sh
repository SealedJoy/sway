#!/usr/bin/env bash
[[ -f /home/sealyj/.cache/wal/sequences ]] && cat /home/sealyj/.cache/wal/sequences
tmux has-session -t "Music" > /dev/null 2>&1
if [ $? != 0 ] ; then
	tmux new-session -s 'Music' -n "Find Music:" $HOME/projects/sway/yt_music/tmux_music_session.sh
else
	tmux attach -t Music
	tmux select-window -t Music:1
	#tmux select-pane -D
	
fi
