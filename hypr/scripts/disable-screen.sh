#!/bin/bash

default_monitor='eDP-1'
monitors=$(xrandr | grep connected | awk '{print $1}')

found=0

for monitor in $monitors; do
    if [ $monitor = $default_monitor ]; then 
        found=1
    fi
done

if [ $found -eq 1 ]; then 
    hyprctl keyword monitor $default_monitor,disable
else 
    hyprctl keyword monitor $default_monitor,preferred,auto,1
fi
