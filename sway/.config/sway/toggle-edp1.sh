#!/bin/bash
# Toggle the laptop screen eDP-1 on/off while docked.
# Stops kanshi when enabling so it doesn't override our manual settings;
# restarts kanshi when disabling so dock/undock auto-switching resumes.
if swaymsg -t get_outputs 2>/dev/null | jq -e 'any(.[]; .name == "eDP-1" and .active)' >/dev/null 2>&1; then
    # eDP-1 is on -> turn it off and let kanshi resume managing outputs
    swaymsg output eDP-1 disable
    pkill -x kanshi; kanshi >/dev/null 2>&1 &
else
    # eDP-1 is off -> stop kanshi, enable both outputs with correct settings
    pkill -x kanshi
    swaymsg 'output HDMI-A-1 mode 1920x1080@144Hz pos 0 0, output eDP-1 enable mode 2880x1800@120Hz scale 1.6 pos -1800 0'
fi
