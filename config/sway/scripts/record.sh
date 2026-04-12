#!/bin/bash
# record.sh [sound|region]
#   (no arg) — record full screen, no sound
#   sound    — record full screen with sound
#   region   — interactive region select

SAVE_DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"
mkdir -p "$SAVE_DIR"
FILE="$SAVE_DIR/$(date +%Y-%m-%d_%H-%M-%S).mp4"

# If already recording, stop
if pgrep -x gpu-screen-recorder > /dev/null; then
    pkill -SIGINT gpu-screen-recorder
    notify-send "Recording stopped" "Saved to $SAVE_DIR"
    exit 0
fi

FOCUSED=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')

case "${1:-}" in
    sound)
        notify-send "Recording started" "With audio — click to stop"
        gpu-screen-recorder -w "$FOCUSED" -a default_output -o "$FILE"
        ;;
    region)
        REGION=$(slurp)
        [ -z "$REGION" ] && exit 1
        notify-send "Recording started" "Region — click to stop"
        gpu-screen-recorder -w region -region "$REGION" -o "$FILE"
        ;;
    *)
        notify-send "Recording started" "No audio — click to stop"
        gpu-screen-recorder -w "$FOCUSED" -o "$FILE"
        ;;
esac
