#!/bin/bash
# Autostart script — runs on every sway reload

pkill -x waybar; waybar &
pkill -x swaync; swaync &
pkill -x fcitx5; fcitx5 -d &

# Idle / lock daemon
pkill -x swayidle
swayidle -w \
    timeout 300  'swaylock -f' \
    timeout 600  'swaymsg "output * power off"' \
    resume       'swaymsg "output * power on"' \
    before-sleep 'swaylock -f' &
