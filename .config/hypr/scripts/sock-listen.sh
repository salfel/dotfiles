#/usr/bin/env bash

handle() {
    event=$(echo $1 | cut -d'>' -f1)
    data=$(echo $1 | cut -d'>' -f3)

    case $event in
        openwindow) open_window $data  ;;
        monitorremovedv2) monitor_removed $data ;;
    esac
}

open_window() {
    address=$(echo $1 | cut -d',' -f1)
    class=$(echo $1 | cut -d',' -f3)

    if [[ $class == "gcr-prompter" ]]; then
        hyprctl dispatch closewindow address:0x$address
    fi
}

monitor_removed() {
    if [ -f ~/disabled-integrated-screen.tmp ]; then
        rm ~/disabled-integrated-screen.tmp
        return
    fi

    hyprctl reload
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
