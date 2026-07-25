#!/bin/bash
# Session / power menu via fuzzel

OPTIONS="  Lock\n  Suspend\n  Hibernate\n󰜉  Reboot\n  Shutdown\n  Logout"

CHOICE=$(echo -e "$OPTIONS" | fuzzel --dmenu --prompt "Session " --lines 6 --width 20)

case "$CHOICE" in
    *"Lock")       swaylock ;;
    *"Suspend")    systemctl suspend-then-hibernate ;;
    *"Hibernate")  systemctl hibernate ;;
    *"Reboot")     systemctl reboot ;;
    *"Shutdown")   systemctl poweroff ;;
    *"Logout")     swaymsg exit ;;
esac
