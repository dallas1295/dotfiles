#!/bin/bash

while :; do
    # Date and time
    date=$(date "+%Y/%m/%d")
    current_time=$(date "+%H:%M")

    # Battery
    if command -v upower >/dev/null 2>&1; then
        battery_info=$(upower --show-info $(upower --enumerate | grep 'BAT' | head -n1))
        battery_charge=$(echo "$battery_info" | grep -E "percentage" | awk '{print $2}')
        battery_status=$(echo "$battery_info" | grep -E "state" | awk '{print $2}')
        battery_percent=$(echo "$battery_charge" | tr -d '%')
    else
        battery_charge="N/A"
        battery_status="unknown"
        battery_percent=0
    fi

    # Waybar-style dynamic battery icon
    if [ "$battery_status" = "charging" ] || [ "$battery_status" = "fully-charged" ]; then
        if   [ "$battery_percent" -ge 95 ]; then battery_icon="󰂅"
        elif [ "$battery_percent" -ge 85 ]; then battery_icon="󰂋"
        elif [ "$battery_percent" -ge 75 ]; then battery_icon="󰂊"
        elif [ "$battery_percent" -ge 65 ]; then battery_icon="󰢞"
        elif [ "$battery_percent" -ge 55 ]; then battery_icon="󰂉"
        elif [ "$battery_percent" -ge 45 ]; then battery_icon="󰢝"
        elif [ "$battery_percent" -ge 35 ]; then battery_icon="󰂈"
        elif [ "$battery_percent" -ge 25 ]; then battery_icon="󰂇"
        elif [ "$battery_percent" -ge 15 ]; then battery_icon="󰂆"
        else                                 battery_icon="󰢜"
        fi
    else
        if   [ "$battery_percent" -ge 95 ]; then battery_icon="󰁹"
        elif [ "$battery_percent" -ge 85 ]; then battery_icon="󰂂"
        elif [ "$battery_percent" -ge 75 ]; then battery_icon="󰂁"
        elif [ "$battery_percent" -ge 65 ]; then battery_icon="󰂀"
        elif [ "$battery_percent" -ge 55 ]; then battery_icon="󰁿"
        elif [ "$battery_percent" -ge 45 ]; then battery_icon="󰁾"
        elif [ "$battery_percent" -ge 35 ]; then battery_icon="󰁽"
        elif [ "$battery_percent" -ge 25 ]; then battery_icon="󰁼"
        elif [ "$battery_percent" -ge 15 ]; then battery_icon="󰁻"
        else                                 battery_icon="󰁺"
        fi
    fi

    # Brightness
    if command -v brightnessctl >/dev/null 2>&1; then
        brightness_percent=$(brightnessctl get)
        brightness_max=$(brightnessctl max)
        brightness_value=$(( 100 * brightness_percent / brightness_max ))
        if   [ "$brightness_value" -ge 95 ]; then brightness_icon="󰛨"
        elif [ "$brightness_value" -ge 85 ]; then brightness_icon="󱩖"
        elif [ "$brightness_value" -ge 75 ]; then brightness_icon="󱩕"
        elif [ "$brightness_value" -ge 65 ]; then brightness_icon="󱩔"
        elif [ "$brightness_value" -ge 55 ]; then brightness_icon="󱩓"
        elif [ "$brightness_value" -ge 45 ]; then brightness_icon="󱩒"
        elif [ "$brightness_value" -ge 35 ]; then brightness_icon="󱩑"
        elif [ "$brightness_value" -ge 25 ]; then brightness_icon="󱩐"
        elif [ "$brightness_value" -ge 15 ]; then brightness_icon="󱩏"
        else                                   brightness_icon="󱩎"
        fi
        brightness_display=$(printf "%3s%%" "$brightness_value")
    else
        brightness_icon="󰛨"
        brightness_display="N/A"
    fi

    # Audio
    if command -v pamixer >/dev/null 2>&1; then
        audio_volume=$(pamixer --get-volume 2>/dev/null)
        audio_is_muted=$(pamixer --get-mute 2>/dev/null)
        if [ "$audio_is_muted" = "true" ]; then
            audio_icon="󰝟"
            audio_display_padded="Muted"
        elif [ "$audio_volume" -eq 0 ] 2>/dev/null; then
            audio_icon=""
            audio_display_padded="  0%"
        elif [ "$audio_volume" -le 33 ] 2>/dev/null; then
            audio_icon=""
            audio_display_padded=$(printf "%3s%%" "$audio_volume")
        elif [ "$audio_volume" -le 66 ] 2>/dev/null; then
            audio_icon=""
            audio_display_padded=$(printf "%3s%%" "$audio_volume")
        else
            audio_icon="󰕾"
            audio_display_padded=$(printf "%3s%%" "$audio_volume")
        fi
    else
        audio_icon="󰝟"
        audio_display_padded="Muted"
    fi

    # Media
    if command -v playerctl >/dev/null 2>&1; then
        media_artist=$(playerctl metadata artist 2>/dev/null)
        media_song=$(playerctl metadata title 2>/dev/null)
        player_status=$(playerctl status 2>/dev/null)
    else
        media_artist=""
        media_song=""
        player_status=""
    fi

    # Network (WiFi SSID and Signal Strength)
    if command -v nmcli >/dev/null 2>&1; then
        wifi_ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
        wifi_strength=$(nmcli -t -f in-use,signal dev wifi | grep '^\*' | cut -d: -f2)
        if [ -z "$wifi_strength" ]; then
            wifi_icon="󰖪"  # Disconnected
            wifi_strength="0"
        elif [ "$wifi_strength" -ge 80 ]; then
            wifi_icon="󰤨"
        elif [ "$wifi_strength" -ge 60 ]; then
            wifi_icon="󰤥"
        elif [ "$wifi_strength" -ge 40 ]; then
            wifi_icon="󰤢"
        elif [ "$wifi_strength" -ge 20 ]; then
            wifi_icon="󰤟"
        else
            wifi_icon="󰤯"
        fi
    else
        wifi_ssid="Not Connected"
        wifi_strength=""
        wifi_icon="󰖪"
    fi

    # CPU usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    cpu_usage=$(printf "%.0f" "$cpu_usage")
    cpu_display=$(printf "%3s%%" "$cpu_usage")

    # RAM usage
    ram_usage=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')
    ram_display=$(printf "%3s%%" "$ram_usage")

    # Song status symbol
    if [ "$player_status" = "Playing" ]; then
        song_status='▶'
    elif [ "$player_status" = "Paused" ]; then
        song_status='⏸'
    else
        song_status='⏹'
    fi

    # Output
    echo "$song_status $media_artist - $media_song | $audio_icon $audio_display_padded |  $cpu_display |  $ram_display | $brightness_icon $brightness_display | $wifi_icon $wifi_ssid ($wifi_strength%) | $battery_icon $battery_charge | $date  $current_time"

done

