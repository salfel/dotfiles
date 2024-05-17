#!/bin/bash

count=$(xrandr | grep " connected" | wc -l) 

if [ $count -gt 1 ]; then
    if [ "${SHOW_DISPLAY}" = "1" ]; then
        xrandr --output eDP --auto --output HDMI-A-0 --auto --primary
        export SHOW_DISPLAY=0
    else
        xrandr --output eDP --off --output HDMI-A-0 --auto
        export SHOW_DISPLAY=1
    fi
fi
