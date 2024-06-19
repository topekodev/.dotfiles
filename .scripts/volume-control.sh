#!/usr/bin/env bash

ARG=$1
if [ -z $ARG ]; then
    echo "Usage: $0 <up|down|toggle-sink|toggle-source>"
    exit 1
fi

notify_volume() {
    VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 2 | awk '{print int($1*100)}')
    notify-send "Volume" -h int:value:$VOLUME -h string:synchronous:volume -a volume-control -c indicator -t 1000
}

notify_mute() {
    STATUS=$(wpctl get-volume $1 | cut -d ' ' -f 3)
    MESSAGE=""
    if [[ "$STATUS" == *"MUTED"* ]]; then
        if [[ "$1" == "@DEFAULT_AUDIO_SINK@" ]]; then
            MESSAGE="Sink muted"
        else
            MESSAGE="Source muted"
        fi
    else
        if [[ "$1" == "@DEFAULT_AUDIO_SINK@" ]]; then
            MESSAGE="Sink unmuted"
        else
            MESSAGE="Source unmuted"
        fi
    fi
    notify-send "$MESSAGE" -h string:synchronous:volume -a volume-control -c indicator -t 1000
}

case $1 in
    up)
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
        notify_volume
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        notify_volume
        ;;
    toggle-sink)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        notify_mute "@DEFAULT_AUDIO_SINK@"
        ;;
    toggle-source)
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        notify_mute "@DEFAULT_AUDIO_SOURCE@"
        ;;
    *)
        exit 1
        ;;
esac
