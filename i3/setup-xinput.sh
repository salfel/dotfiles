#!/bin/bash

touchpad_id=$(xinput list | grep "Touchpad" | awk -F'=' '{print $2}' | awk '{print $1}')

xinput set-prop "$touchpad_id" "libinput Tapping Enabled" 1
xinput set-prop "$touchpad_id" 295 1
