#!/usr/bin/env bash

CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)
WARNING=$(cat ~/.config/waybar/state/battery-warning)
CRITICAL=$(cat ~/.config/waybar/state/battery-critical)

# Battery states

if [ $STATUS = "Discharging" ] && [ $CAPACITY -le 20 ]; then
    if [ $(($WARNING)) -eq 0 ]; then
        notify-send -u critical "Low Battery" "$CAPACITY% battery remaining." -a battery-event -c indicator
    fi
    echo 1 > ~/.config/waybar/state/battery-warning
else
    echo 0 > ~/.config/waybar/state/battery-warning
fi

if [ $STATUS = "Discharging" ] && [ $CAPACITY -le 10 ]; then
    if [ $(($CRITICAL)) -eq 0 ]; then
        notify-send -u critical "Low Battery" "Your computer will hibernate soon unless plugged into a power outlet." -a battery-event -c indicator
    fi
    echo 1 > ~/.config/waybar/state/battery-critical
else
    echo 0 > ~/.config/waybar/state/battery-critical
fi

# Hibernate

if [ $STATUS = "Discharging" ] && [ $CAPACITY -le 5 ]; then
    systemctl hibernate
fi
