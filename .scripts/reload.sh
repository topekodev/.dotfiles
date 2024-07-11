#!/usr/bin/env bash

# Hyprland
hyprctl reload

# Waybar
if [ -z $(pidof waybar) ]; then
    waybar &
else
    killall -SIGUSR2 waybar
fi

# Dunst
killall dunst
dunst &

# Notify
notify-send "Reloaded" -a reload -c indicator -t 1000
