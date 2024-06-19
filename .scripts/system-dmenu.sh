#!/usr/bin/env bash

input=$(echo -e " Lock\n Exit\n  Suspend\n Hibernate\n Reboot\n Poweroff" | fuzzel --dmenu --prompt "System: ")

case $input in
    " Lock")
        loginctl lock-session
        ;;
    " Exit")
        hyprctl dispatch exit
        ;;
    "  Suspend")
        systemctl suspend-then-hibernate
        ;;
    " Hibernate")
        systemctl hibernate
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Poweroff")
        systemctl poweroff
        ;;
esac
