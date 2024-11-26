#!/usr/bin/env bash

# Check dependencies
if ! command -v swaybg &> /dev/null; then
    echo "swaybg not found"
    exit 1
fi
if ! command -v magick &> /dev/null; then
    echo "magick not found"
    exit 1
fi
if ! command -v fd &> /dev/null; then
    echo "fd not found"
    exit 1
fi

# Symlink current wallpaper
DATA_DIR=~/.wallpaper
mkdir -p $DATA_DIR

set_bg() {
    if [[ "$1" == "image" ]]; then
        if [ -f "$DATA_DIR/current" ]; then
            rm "$DATA_DIR/current"
        fi
        cp "$2" "$DATA_DIR/current"
        echo "$2" > "$DATA_DIR/current.txt"
    elif [[ "$1" == "color" ]]; then
        if [ -f "$DATA_DIR/current" ]; then
            rm "$DATA_DIR/current"
        fi
        magick -size 1920x1080 canvas:"$2" "$DATA_DIR/color.jpg"
        mv "$DATA_DIR/color.jpg" "$DATA_DIR/current"
        echo "$2" > "$DATA_DIR/current.txt"
    fi

    # Start swaybg
    PID=$(pidof swaybg)
    if [ -z "$PID" ]; then
        swaybg -i "$DATA_DIR/current" &> /dev/null &
    else
        kill $PID
        swaybg -i "$DATA_DIR/current" &> /dev/null &
    fi

    echo "$2" 
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
        set_bg "color" "$COLOR"
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
        if ! file "$BG" | grep "image data" &> /dev/null; then
            echo "File is not an image"
            exit 1
        fi
        set_bg "image" "$BG"
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
        BG_DIR_SIZE=$(fd . $BG_DIR -e jpg -e jpeg -e png | wc -l)
        BG_CURRENT=$(cat ~/.wallpaper/current.txt)
        BG=$(fd . $BG_DIR -e jpg -e jpeg -e png | shuf -n 1)
        if [ "$BG_DIR_SIZE" -gt "1" ]; then
            while [[ "$BG" == "$BG_CURRENT" ]]; do
                BG=$(fd . $BG_DIR -e jpg -e jpeg -e png | shuf -n 1)
            done
        fi
        if ! file "$BG" | grep "image data" &> /dev/null; then
            echo "File is not an image"
            exit 1
        fi
        set_bg "image" "$BG"
        ;;
    *)
        set_bg "color" "#000000"
        ;;
esac
