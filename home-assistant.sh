#!/usr/bin/env bash 
USER=sealyj
XDG_RUNTIME_DIR=/run/user/1000
DISPLAY=:0

current_app=$(swaymsg -t get_tree | jq -r '..|try select(.focused == true)' | jq -r "..|try select(.fullscreen_mode == 1)")
play /home/sealyj/Music/PremiumBeat_0046_sci_fi_beep_electric.wav &
if [ -z "$current_app" ] ; then
	#user not focused in fullscreen mode 
	#launch in tiled mode
#	firefox -P camera_stream -width 60 -height 60 -new-window --kiosk http://deb.lan:8123/lovelace/monitor &
	qutebrowser --target=window http://deb.lan:8123/lovelace/0 &
else
	#user focused in fullscreen 
	#launch exit from fullscreen
	sway fullscreen toggle
	qutebrowser --target=window http://deb.lan:8123/lovelace/0 &
	#firefox -P camera_stream -width 60 -height 60 -new-window --kiosk http://deb.lan:8123/lovelace/monitor &
fi
