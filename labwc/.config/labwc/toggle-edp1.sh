#!/bin/bash
# Toggle the laptop screen eDP-1 on/off while docked (labwc port of
# ~/.config/sway/toggle-edp1.sh; uses wlr-randr instead of swaymsg).
#
# Stops kanshi when enabling so it doesn't override our manual settings;
# restarts kanshi when disabling so dock/undock auto-switching resumes.

if wlr-randr --json 2>/dev/null | jq -e 'any(.[]; .name == "eDP-1" and .active)' >/dev/null 2>&1; then
    # eDP-1 is on: turn it off and let kanshi resume managing outputs
    wlr-randr --output eDP-1 --off
    pkill -x kanshi; kanshi >/dev/null 2>&1 &
else
    # eDP-1 is off: stop kanshi, enable both outputs with fixed geometry
    # (equals position=-1800,0 form is used because -1800,0 looks like a flag)
    pkill -x kanshi
    wlr-randr --output HDMI-A-1 --mode 1920x1080@144 --position=0,0 \
              --output eDP-1 --on --mode 2880x1800@120 --scale 1.6 --position=-1800,0
fi
