#!/bin/sh
until xrandr --output XWAYLAND0 --primary 2>/dev/null; do
    sleep 2
done
