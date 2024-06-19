#!/usr/bin/env bash

INPUT=$(fcitx5-remote -n)

case $INPUT in 
    "keyboard-fi")
        indicator="fi"
        ;;
    "pinyin")
        indicator="拼"
        ;;
    *)
        indicator="$INPUT"
esac

tooltip="$INPUT"
text="$indicator"
class=""

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
