#!/usr/bin/env bash

ENABLED=
DISABLED=
if [ -z $(pidof uxplay) ]; then
    text=$DISABLED
    tooltip="Casting disabled"
    class="disabled"
else
    text=$ENABLED
    tooltip="Casting enabled"
    class="enabled"
fi

echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\", \"class\":\"$class\"}"
