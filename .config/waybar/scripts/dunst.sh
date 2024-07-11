#!/usr/bin/env bash

WAITING=$(dunstctl count waiting)
HISTORY=$(dunstctl count history)
ENABLED=
DISABLED=
if dunstctl is-paused | grep -q "false" ; then
    text=$ENABLED
    tooltip="History: $HISTORY"
    class="activated"
else
    if [ $WAITING != 0]; then
        text="$DISABLED•"
    else
        text=$DISABLED
    fi
    tooltip="Waiting: $WAITING"
    class="deactivated"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
