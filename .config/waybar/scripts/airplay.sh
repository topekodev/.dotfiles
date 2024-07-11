#!/usr/bin/env bash

ENABLED=
DISABLED=
if [ -z $(pidof uxplay) ]; then
    text=$DISABLED
    tooltip="Casting disabled"
    class="deactivated"
else
    text=$ENABLED
    tooltip="Casting enabled"
    class="activated"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
