#!/bin/bash
# Autostart script — runs on every sway reload

pkill -x swaync; swaync &
# ags bar disabled — ~/.config/ags doesn't exist, so this only failed each reload.
# Re-enable (and create the ags config) if you ever want a status bar back.
# pkill gjs; ags run --gtk 3 --directory ~/.config/ags &
pkill -x fcitx5; sleep 0.5; fcitx5 -d &

# EasyEffects (오디오 EQ, LG-gram-Windows-like 프리셋 자동 복원).
# 단일 인스턴스 + 리로드마다 재시작하면 소리가 끊기므로, 안 떠 있을 때만 시작.
pgrep -x easyeffects >/dev/null || easyeffects --service-mode &

# Idle / lock daemon
pkill -x swayidle
swayidle -w \
    timeout 300  'swaylock -f' \
    timeout 600  'swaymsg "output * power off"' \
    resume       'swaymsg "output * power on"' \
    before-sleep 'swaylock -f' &
