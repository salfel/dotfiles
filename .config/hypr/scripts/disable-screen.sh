#!/usr/bin/env bash

default_monitor=eDP-1
monitors=$(xrandr | grep connected | awk '{print $1}' | wc -l)

if [ $monitors -eq 2 ]; then 
    hyprctl keyword monitor $default_monitor,disable
else 
    hyprctl keyword monitor $default_monitor,preferred,auto,1
fi
