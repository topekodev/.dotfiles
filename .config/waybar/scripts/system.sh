#!/usr/bin/env bash

UPDATES=$(checkupdates | wc -l)
tooltip="$UPDATES updates available"

if [ $UPDATES -gt 0 ]; then
    notify-send "Updates available" "$UPDATES package(s) available for update."
fi

echo "{\"tooltip\":\"$tooltip\"}"
