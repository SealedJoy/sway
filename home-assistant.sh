#!/usr/bin/env bash 
USER=sealyj
XDG_RUNTIME_DIR=/run/user/1000
DISPLAY=:0
#KITTY_ENABLE_WAYLAND=1
#WAYLAND_DISPLAY=wayland-1
#firefox -P camera_stream -width 60 -height 60 -new-window --kiosk http://192.168.1.105:8081 &
#sway floating enable, resize set 590 px 333 px, move window to position 776 px 405 px

current_app=$(swaymsg -t get_tree | jq -r '..|try select(.focused == true)' | jq -r "..|try select(.fullscreen_mode == 1)")
play /home/sealyj/Music/PremiumBeat_0046_sci_fi_beep_electric.wav &
if [ -z "$current_app" ] ; then
	#user not focused in fullscreen mode 
	#launch in tiled mode
	#sway exec "mpv --vid=1 --framedrop=decoder+vo --no-correct-pts --fps=7 --wayland-app-id=summoned_tile --window-scale=0.4 http://192.168.1.105:8081"
	firefox -P camera_stream -width 60 -height 60 -new-window --kiosk http://192.168.1.145:8123/lovelace/monitor &
else
	#user focused in fullscreen 
	#launch exit from fullscreen
	#sway exec "timeout 7 mpv --vid=1 --framedrop=decoder+vo --no-correct-pts --fps=7 --wayland-app-id=cancel_fullscreen --window-scale=0.4 http://192.168.1.105:8081"
	sway fullscreen toggle
	firefox -P camera_stream -width 60 -height 60 -new-window --kiosk http://192.168.1.145:8123/lovelace/monitor &
	sway fullscreen toggle
	#sway exec "timeout 7 mpv --vid=1 --framedrop=decoder+vo --no-correct-pts --fps=7 --wayland-app-id=summoned_tile --window-scale=0.4 http://192.168.1.105:8081"
fi
#sway exec "vlc http://192.168.1.105:8081"
#sway exec "mpv --vid=1 --no-correct-pts --fps=7 --wayland-app-id=summoned --window-scale=0.4 http://192.168.1.105:8081"
#cool-retro-term --fullscreen -e timeout 1.7 /usr/bin/cava &
