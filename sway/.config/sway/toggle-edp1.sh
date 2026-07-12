#!/bin/bash
# Toggle the laptop screen eDP-1. Off -> on (right of HDMI); on -> off.
if swaymsg -t get_outputs 2>/dev/null | jq -e 'any(.[]; .name == "eDP-1" and .active)' >/dev/null 2>&1; then
    swaymsg output eDP-1 disable
else
    swaymsg 'output eDP-1 enable, output eDP-1 pos 1920 0'
fi
