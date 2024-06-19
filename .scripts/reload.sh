#!/usr/bin/env bash

# Waybar
if [ -z $(pidof waybar) ]; then
    waybar &
else
    killall -SIGUSR2 waybar
fi

# Dusnt
killall dunst
dunst &

# Notify
notify-send "Reloaded" -a reload -c indicator -t 1000
