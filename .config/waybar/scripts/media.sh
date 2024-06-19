#!/usr/bin/env bash

STATUS=$(playerctl status --no-messages)
PLAY_ICON=""
PAUSE_ICON=""

if [ "$STATUS" = "Playing" ]; then
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    if [ -z $artist ]; then
        tooltip="$title"
    else
        tooltip="$artist - $title"
    fi
    text="$PAUSE_ICON"
    class="playing"
elif [ "$STATUS" = "Paused" ]; then
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    if [ -z $artist ]; then
        tooltip="$title"
    else
        tooltip="$artist - $title"
    fi
    text="$PLAY_ICON"
    class="paused"
else
    text=""
    tooltip=""
    class="stopped"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
