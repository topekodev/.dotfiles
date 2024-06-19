#/usr/bin/env bash

ARG=$1
if [ -z $ARG ]; then
    echo "Usage: $0 <area|area-clipboard|fullscreen|fullscreen-clipboard>"
    exit 1
fi

CLIPBOARD=wl-copy
LOCATION=~/Pictures/Screenshots
mkdir -p $LOCATION

case $ARG in
    area)
        filename=$LOCATION/screenshot-$(date +%s).png
        slurp | grim -g - $filename
        notify-send -t 3000 "Screenshot saved" "$filename"
        ;;
    area-clipboard)
        slurp | grim -g - - | $CLIPBOARD
        notify-send -t 3000 "Screenshot copied to clipboard" "Use Ctrl+v to paste."
        ;;
    fullscreen)
        filename=$LOCATION/screenshot-$(date +%s).png
        grim $filename
        notify-send -t 3000 "Screenshot saved" "$filename"
        ;;
    fullscreen-clipboard)
        grim - | $CLIPBOARD
        notify-send -t 3000 "Screenshot copied to clipboard" "Use Ctrl+v to paste."
        ;;
    *)
        exit 1
        ;;
esac
