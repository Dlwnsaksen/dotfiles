#!/bin/bash
# Toggle touchpad on/off — device-agnostic (matches by type, not hardcoded ID)

state=$(swaymsg -t get_inputs \
    | jq -r 'first(.[] | select(.type == "touchpad") | .libinput.send_events)')

if [ -z "$state" ] || [ "$state" = "null" ]; then
    notify-send -i input-touchpad "터치패드" "장치를 찾을 수 없음" -t 2000
    exit 1
fi

if [ "$state" = "enabled" ]; then
    swaymsg input type:touchpad events disabled
    notify-send -i input-touchpad-off "터치패드" "비활성화됨" -t 2000
else
    swaymsg input type:touchpad events enabled
    notify-send -i input-touchpad "터치패드" "활성화됨" -t 2000
fi
