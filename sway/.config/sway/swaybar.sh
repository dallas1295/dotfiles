#!/bin/bash
# swaybar status (Gruber darker, monochrome #E4E4E4)
# Visual order right-to-left: time · brightness(%) · wifi · storage · ram · cpu
# status text renders left-to-right, so rightmost item is last in the string.

bright_icons=(󱩎 󱩏 󱩐 󱩑 󱩒 󱩓 󱩔 󱩕 󱩖 󰛨)
wifi_icons=(󰤯 󰤟 󰤢 󰤥 󰤨)
cpu_icon=$'\uF2DB'   # microchip
ram_icon=$'\uEFC5'   # memory

clamp() { [ "$1" -lt "$2" ] && { echo "$2"; return; }; [ "$1" -gt "$3" ] && { echo "$3"; return; }; echo "$1"; }

while :; do
    # cpu
    cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/{print 100 - $8}')
    cpu_usage=$(printf "%.0f"  "$cpu_usage")
    cpu=$(printf "%s %3s%%"  "$cpu_icon" "$cpu_usage")

    # memory
    ram_used=$(free -h | awk '/Mem:/ {printf "%.1fG", $3}')
    ram_total=$(free -h | awk '/Mem:/ {printf "%.1fG", $2}')
    ram="${ram_icon} ${ram_used}/${ram_total}"

    # disk (/mnt)
    disk_info=$(df -h /mnt 2>/dev/null | awk 'NR==2{printf "%s/%s", $3, $2}')
    disk=" 󰋊 ${disk_info:-N/A}"

    # wifi
    ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '/^yes/{print $2}')
    if [ -n "$ssid" ]; then
        signal=$(nmcli -t -f in-use,signal dev wifi 2>/dev/null | awk -F: '/^\*/{print $2}')
        signal=${signal:-0}
        if   [ "$signal" -ge 80 ]; then w=4
        elif [ "$signal" -ge 60 ]; then w=3
        elif [ "$signal" -ge 40 ]; then w=2
        elif [ "$signal" -ge 20 ]; then w=1
        else w=0; fi
        wifi=" ${wifi_icons[$w]} ${ssid}"
    else
        eth=$(nmcli -t -f TYPE,STATE dev 2>/dev/null | awk -F: '$1=="ethernet" && $2=="connected"{print; exit}')
        if [ -n "$eth" ]; then wifi=" 󰈀"; else wifi=" ⚠"; fi
    fi

    # brightness (icon + %)
    b_cur=$(brightnessctl get 2>/dev/null)
    b_max=$(brightnessctl max 2>/dev/null)
    b_pct=$(( b_max > 0 ? 100 * b_cur / b_max : 0 ))
    b_idx=$(clamp $(( b_pct / 10 )) 0 9)
    bright=$(printf " %s %3s%%" "${bright_icons[$b_idx]}" "$b_pct")

    # clock
    clock=" $(date '+%H:%M') "

    echo "${cpu} ${ram} ${disk} ${wifi} ${bright} ${clock}"
    sleep 1
done
