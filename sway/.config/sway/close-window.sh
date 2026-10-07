#!/bin/bash
# Close the focused window. Steam gets `steam -shutdown` instead of a plain
# kill so the whole client exits rather than hiding in a tray we don't have
# (its window-close behavior otherwise leaves a windowless background process).

focused=$(swaymsg -t get_tree | jq -r '
    .. | select(.focused? == true)
    | .window_properties.class // .app_id // empty')

case "${focused,,}" in
    steam) steam -shutdown ;;
    *)     swaymsg kill ;;
esac
