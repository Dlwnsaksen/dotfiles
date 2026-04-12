#!/bin/bash
# screenshot.sh [screen|region]
#   screen — full screen → clipboard + file
#   region — interactive region select → clipboard + swappy editor

SAVE_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$SAVE_DIR"
FILE="$SAVE_DIR/$(date +%Y-%m-%d_%H-%M-%S).png"

case "${1:-screen}" in
    screen)
        grim "$FILE" && wl-copy < "$FILE"
        notify-send -i "$FILE" "Screenshot saved" "$FILE"
        ;;
    region)
        grim -g "$(slurp)" - | swappy -f -
        ;;
esac
