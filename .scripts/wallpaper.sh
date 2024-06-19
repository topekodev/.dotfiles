#!/usr/bin/env bash

set_bg() {
    PID=$(pidof swaybg)
    if [ -z "$PID" ]; then
        swaybg "$1" "$2" &
    else
        kill $PID
        swaybg "$1" "$2" &
    fi
}

case $1 in
    -h|--help)
        echo "Usage: $0 <option>"
        echo ""
        echo "  -h, --help              Show help message and exit"
        echo "  -c, --color <#HEX>      Set background color"
        echo "  -i, --image <image>     Set background image"
        echo "  -d, --directory <dir>   Set random image from directory"
        exit 0
        ;;
    -c|--color)
        COLOR=$2
        if [ -z "$COLOR" ]; then
            echo "No color passed as an argument"
            exit 1
        fi
        if [[ ! "$COLOR" =~ ^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$ ]]; then
            echo "Invalid color $COLOR"
            exit 1
        fi
        set_bg "-c" "$COLOR"
        ;;
    -i|--image)
        BG=$2
        if [ -z "$BG" ]; then
            echo "No image passed as an argument"
            exit 1
        fi
        if [ ! -f "$BG" ]; then
            echo "File $BG does not exist"
            exit 1
        fi
        set_bg "-i" "$BG"
        ;;
    -d|--directory)
        BG_DIR=$2
        if [ -z "$BG_DIR" ]; then
            echo "No directory passed as an argument"
            exit 1
        fi
        if [ ! -d "$BG_DIR" ]; then
            echo "Directory $BG_DIR does not exist"
            exit 1
        fi
        if [ -z "$(ls -A $BG_DIR)" ]; then
            echo "Directory $BG_DIR is empty"
            exit 1
        fi
        BG="$BG_DIR/"$(ls $BG_DIR | shuf -n 1)
        set_bg "-i" "$BG"
        ;;
    *)
        set_bg "-c" "#000000"
        ;;
esac
