#!/usr/bin/env bash 
#DISPLAY=:0
#KITTY_ENABLE_WAYLAND=1
WAYLAND_DISPLAY=wayland-1
stream_hostname="192.168.1.12"
backup_stream="http://deb.lan:8123/lovelace/0"
stream="http://192.168.1.12:8081"
 
play /home/sealyj/Music/PremiumBeat_0046_sci_fi_beeps_4.wav &>/dev/null  
#### TEST ROUTE ####
ping -W 0.6 -c 1 bg_cam_pi >/dev/null                     # Try once.
rc=$?
if [[ $rc -eq 0 ]] ; then
	#camera direct stream contactable
	launch_cam_command="mpv --no-audio --video-reversal-buffer=240MiB --vid=1 --framedrop=vo --no-correct-pts --fps=7 --wayland-app-id=float-video --window-scale=0.4 $stream"
#	stop_cam_command="killall -SIGUSR1 mpv"
	sleep_time=12
else
	echo "launching through browser"
	#take longer route
	launch_cam_command="wyeb $backup_stream"
	stop_cam_command="killall -SIGUSR1 wyeb"
	sleep_time=25
fi
######
current_app=$(swaymsg -t get_tree | jq -r '..|try select(.focused == true)' | jq -r "..|try select(.fullscreen_mode == 1)")
if [ -z "$current_app" ] ; then
	#user focus not in fullscreen app 
	#launch in tiled modez
	if [ "$1" == "-a" ] || [ "$1" == "-t" ] ; then # -a for automate 
		$launch_cam_command &
		sleep $sleep_time
		#$stop_cam_command
		kill $! > /dev/null
	else
		$launch_cam_command
	fi
else
	#user focused in fullscreen 
	#exit from fullscreen
	#sway mark --add return_to_fullscreen
	sway fullscreen disable
	if [ "$1" == "-a" ] ; then # -a for automate 
		$launch_cam_command &
		sleep $sleep_time
		$stop_cam_command
		#sway [con_mark="return_to_fullscreen"] focus

		#sway fullscreen toggle
		#sway mark --replace return_to_fullscreen
	else 	
		$launch_cam_command
	fi
fi
