#!/bin/sh
WIDTHS="0.3 0.5 0.7"
ACTIVE=$(hyprctl activewindow -j | jq -r '.at[0]')
CUR=$(hyprctl activewindow -j | jq -r '.size[0]')
MONITOR=$(hyprctl activewindow -j | jq -r '.monitor')
MON_W=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$MONITOR\") | .width / .scale")
RATIO=$(echo "$CUR / $MON_W" | bc -l)

FIRST=1
FOUND=""
for W in $WIDTHS; do
	if [ "$FIRST" = 1 ]; then
		FIRST_VAL=$W
		FIRST=0
	fi
	if [ 1 -eq "$(echo "$RATIO < $W" | bc)" ]; then
		FOUND=$W
		break
	fi
done

if [ -z "$FOUND" ]; then
	FOUND=$FIRST_VAL
fi

hyprctl dispatch layoutmsg colresize "$FOUND"
