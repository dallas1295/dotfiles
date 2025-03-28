#!/usr/bin/env bash

# Debug: Show the raw output from hyprctl
echo "Raw hyprctl output:" > /tmp/gamemode_debug.log
hyprctl getoption animations:enabled >> /tmp/gamemode_debug.log

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | grep 'int' | awk '{print $2}')
echo "Parsed HYPRGAMEMODE value: $HYPRGAMEMODE" >> /tmp/gamemode_debug.log

if [ "$HYPRGAMEMODE" = "1" ] ; then
    echo "Turning game mode ON" >> /tmp/gamemode_debug.log
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
    notify-send "Game Mode: ON" "Disabled animations and effects"
else
    echo "Turning game mode OFF" >> /tmp/gamemode_debug.log
    hyprctl --batch "\
        keyword animations:enabled 1;\
        keyword decoration:drop_shadow 1;\
        keyword decoration:blur 1;\
        keyword general:gaps_in 2;\
        keyword general:gaps_out 2;\
        keyword general:border_size 2;\
        keyword decoration:rounding 10"
    notify-send "Game Mode: OFF" "Enabled animations and effects"
fi

