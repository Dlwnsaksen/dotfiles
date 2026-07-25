#!/bin/bash
# Toggle touchpad on/off

TOUCHPAD="1267:13030:PNP0C50:00_04F3:32E6_Touchpad"

state=$(swaymsg -t get_inputs | jq -r --arg id "$TOUCHPAD" \
    '.[] | select(.identifier == $id) | .libinput.send_events')

if [ "$state" = "enabled" ]; then
    swaymsg input "$TOUCHPAD" events disabled
    notify-send -i input-touchpad-off "터치패드" "비활성화됨" -t 2000
else
    swaymsg input "$TOUCHPAD" events enabled
    notify-send -i input-touchpad "터치패드" "활성화됨" -t 2000
fi
