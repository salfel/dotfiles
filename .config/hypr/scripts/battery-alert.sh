#!/usr/bin/env bash

warn_threshold=30
crit_threshold=15

warn_sent=0
crit_sent=0

battery=$(upower -e | grep battery | head -n1)

if [ -z "$battery" ]; then
  echo "No battery found via upower"
  exit 1
fi

while true; do
  percentage=$(
    upower -i "$battery" | awk '/percentage:/ {gsub("%", "", $2); print $2}'
  )
  state=$(upower -i "$battery" | awk '/state:/ {print $2}')

  if [ "$state" = "discharging" ]; then
    if [ "$percentage" -le "$crit_threshold" ] && [ "$crit_sent" -eq 0 ]; then
      notify-send -u critical "Battery critical" \
        "Battery is at ${percentage}%"
      crit_sent=1
    elif [ "$percentage" -le "$warn_threshold" ] && [ "$warn_sent" -eq 0 ]; then
      notify-send -u normal "Battery low" \
        "Battery is at ${percentage}%"
      warn_sent=1
      crit_sent=0
    fi
  else
    warn_sent=0
    crit_sent=0
  fi

  sleep 60
done
