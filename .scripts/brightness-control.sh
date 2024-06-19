#!/usr/bin/env bash

ARG=$1
if [ -z $ARG ]; then
    echo "Usage: $0 <up|down>"
    exit 1
fi

case $1 in
    up)
        brightnessctl set +10%
        ;;
    down)
        brightnessctl --min-value=10 set 10%-
        ;;
    *)
        exit 1
        ;;
esac

MAX=$(brightnessctl max)
VALUE=$(brightnessctl get)
BRIGHTNESS=$(awk "BEGIN {print int(($VALUE/$MAX)*100)}")

notify-send "Brightness" -h int:value:$BRIGHTNESS -h string:synchronous:brightness -a brightness-control -c indicator -t 1000
