#!/usr/bin/env bash 
USER=sealyj
XDG_RUNTIME_DIR=/run/user/1000
DISPLAY=:0
KITTY_ENABLE_WAYLAND=1
WAYLAND_DISPLAY=wayland-1
#kitty --start-as fullscreen --detach --hold --execute timeout 15 /usr/bin/cava
foot -F timeout 1.7 /usr/bin/cava &
sleep 3
#cool-retro-term --fullscreen -e timeout 1.7 /usr/bin/cava &
sleep 0.4
play -v 0.2 /home/sealyj/Music/turret_hello.wav
