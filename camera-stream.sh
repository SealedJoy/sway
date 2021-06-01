#!/usr/bin/env bash 
#DISPLAY=:0
#KITTY_ENABLE_WAYLAND=1
WAYLAND_DISPLAY=wayland-1
 
play /home/sealyj/Music/PremiumBeat_0046_sci_fi_beeps_4.wav &>/dev/null  
#### TEST ROUTE ####
ping -W 0.6 -c 1 192.168.1.105 >/dev/null                     # Try once.
rc=$?
if [[ $rc -eq 0 ]] ; then
	#camera direct stream contactable
	launch_cam_command="mpv --video-reversal-buffer=240MiB --vid=1 --framedrop=decoder+vo --no-correct-pts --fps=8 --wayland-app-id=summoned_tile --window-scale=0.4 http://192.168.1.105:8081"
	sleep_time=12
else
	echo "launching through browser"
	#take longer route
	#launch_cam_command="firefox -P camera_stream -width 60 -height 60 -new-window --kiosk http://192.168.1.145:8123/lovelace/0; sway fullscreen toggle"
	launch_cam_command="qutebrowser --target=window http://192.168.1.145:8123/lovelace/0"
	sleep_time=25
fi
######
current_app=$(swaymsg -t get_tree | jq -r '..|try select(.focused == true)' | jq -r "..|try select(.fullscreen_mode == 1)")
if [ -z "$current_app" ] ; then
	#user focus not in fullscreen app 
	#launch in tiled modez
	if [ "$1" == "-a" ] || [ "$1" == "-t" ] ; then # -a for automate 
		$launch_cam_command
	else
		$launch_cam_command
	fi
else
	#user focused in fullscreen 
	#exit from fullscreen
	sway mark --add return_to_fullscreen
	if [ "$1" == "-a" ] ; then # -a for automate 
		sway fullscreen disable
		$launch_cam_command &
		sleep 7.1
		killall -SIGUSR1 qutebrowser >/dev/null
		if [ -n "$current_app_id" ] && [ "$new_app_id" == "$current_app_id" ] ; then
			sway [con_mark="return_to_fullscreen"] focus

			sway fullscreen toggle
			sway mark --replace return_to_fullscreen
		fi
	else 	
		$launch_cam_command &
		sleep 7.1

	fi
fi
