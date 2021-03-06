#!/usr/bin/env bash 
DISPLAY=:0
#WAYLAND_DISPLAY=wayland-1

if [ -z $(which mosquitto_sub) ]; then
  >&2 echo "error: it seems mosquitto_sub is not installed!"
  exit 1
fi
while IFS= read -r line ; do
    /home/sealyj/projects/sway/camera-stream.sh -a $line # || foot 
#done < <(mosquitto_sub $@)
done < <(mosquitto_sub -i "ace_automation" -h 192.168.1.1 --username $MQTT_USER --pw $MQTT_PASS -t 'hardware/spawn_camera_window' -R $@)

