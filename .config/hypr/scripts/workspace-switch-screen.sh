#!/bin/bash

active_monitor=$(hyprctl activeworkspace | grep workspace | awk '{print $7}' | sed -r 's/://')
monitors=$(hyprctl monitors | grep Monitor | awk '{print $2}')

for monitor in $monitors; do 
    if [ $monitor != $active_monitor ]; then 
        hyprctl dispatch movecurrentworkspacetomonitor $monitor
    fi
done
