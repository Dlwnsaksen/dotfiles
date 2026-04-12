#!/bin/bash
# scratchpad.sh <name> [launch_command]
#   Toggles a named scratchpad. If no window exists and a command is given, launches it.

NAME="$1"
CMD="$2"

MATCH=$(swaymsg -t get_tree | jq -r ".. | select(.app_id? == \"$NAME\") | .id" 2>/dev/null | head -1)

if [ -n "$MATCH" ]; then
    swaymsg "[app_id=\"$NAME\"] scratchpad show"
else
    if [ -n "$CMD" ]; then
        eval "$CMD" &
        sleep 0.3
        swaymsg "[app_id=\"$NAME\"] floating enable, resize set 70 ppt 80 ppt, move position center, move scratchpad, scratchpad show"
    fi
fi
