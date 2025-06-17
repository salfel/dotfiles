#!/usr/bin/env bash

default_monitor=eDP-1
monitors=$(xrandr | grep connected | awk '{print $1}' | wc -l)

if [ $monitors -ne 1 ]; then
    hyprctl keyword monitor $default_monitor,disable
fi
