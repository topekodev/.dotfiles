#!/usr/bin/env bash

if [ -z $(pidof uxplay) ]; then
    uxplay -fs -n airplay &
else
    killall uxplay
fi
