#!/usr/bin/env bash 
DISPLAY=:0
#KITTY_ENABLE_WAYLAND=1
WAYLAND_DISPLAY=wayland-1
 
current_app=$(swaymsg -t get_tree | jq -r '..|try select(.focused == true)' | jq -r "..|try select(.fullscreen_mode == 1)")
play /home/sealyj/Music/PremiumBeat_0046_sci_fi_beeps_4.wav & 

ping -W 0.6 -c 1 192.168.1.105                      # Try once.
rc=$?
if [[ $rc -eq 0 ]] ; then
	#camera direct stream contactable
	launch_cam_command="mpv --video-reversal-buffer=240MiB --vid=1 --framedrop=decoder+vo --no-correct-pts --fps=8 --wayland-app-id=summoned_tile --window-scale=0.4 http://192.168.1.105:8081"
	sleep_time=12
else
	#take longer route
	#launch_cam_command="firefox -P camera_stream -width 60 -height 60 -new-window --kiosk http://192.168.1.145:8123/lovelace/0; sway fullscreen toggle"
	launch_cam_command="qutebrowser http://192.168.1.145:8123/lovelace/0"
	sleep_time=25
fi

if [ -z "$current_app" ] ; then
	#user focus not in fullscreen app 
	#launch in tiled modez
	if [ "$1" == "-a" ] || [ "$1" == "-t" ] ; then # -a for automate 
		timeout -s HUP $sleep_time $launch_cam_command
	else
		$launch_cam_command
	fi
else
	#user focused in fullscreen 
	#exit from fullscreen
	sway fullscreen toggle
	current_app_id=$(swaymsg -t get_tree | jq -r '..|try select(.focused == true)' | jq -r "..|try select(.app_id)")
	if [ "$1" == "-a" ] ; then # -a for automate 
		timeout -s HUP $sleep_time $launch_cam_command &
		sleep 7.1
		new_app_id=$(swaymsg -t get_tree | jq -r '..|try select(.focused == true)' | jq -r "..|try select(.app_id)")
		if [ -n "$current_app_id" ] && [ "$new_app_id" == "$current_app_id" ] ; then
			sway fullscreen toggle
		fi
	else 	
		$launch_cam_command &
		sleep 7.1

	fi
fi
