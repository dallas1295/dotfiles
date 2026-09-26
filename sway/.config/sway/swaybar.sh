#!/bin/bash
# swaybar status (Gruber darker, monochrome #E4E4E4)
# Visual order right-to-left: time · battery(%) · brightness(%) · volume(%) · wifi · storage · ram · cpu
# status text renders left-to-right, so rightmost item is last in the string.
#
# Cadence: the loop ticks every 1s but only does fork-free file/sysfs reads
# + date, so brightness/battery/volume/clock update fast. Probes that fork
# external tools (top/free/df/nmcli) run every SLOW ticks, keeping CPU use
# ~flat. Volume is fork-free via a pactl subscriber that refreshes a cache
# file the moment the sink/server changes (slow-path fallback without pactl).

bright_icons=(󱩎 󱩏 󱩐 󱩑 󱩒 󱩓 󱩔 󱩕 󱩖 󰛨)
# low / medium / high (placeholder nerd font icons — swap with dallas's set)
vol_icons=(󰕿 󰖀 󰕾)
vol_mute_icon=󰸈
wifi_icons=(󰤯 󰤟 󰤢 󰤥 󰤨)
battery_icons=(󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)
# charging variants, nearest level this font ships (100/20/30/40/60/80/90 + generic)
charging_icons=(󰢜 󰂆 󰂇 󰂈 󰢝 󰂉 󰢞 󰂊 󰂋 )
cpu_icon=$'\uF2DB'   # microchip
ram_icon=$'\uEFC5'   # memory

clamp() { [ "$1" -lt "$2" ] && { echo "$2"; return; }; [ "$1" -gt "$3" ] && { echo "$3"; return; }; echo "$1"; }

# discover devices once so per-tick reads are plain sysfs (no subprocesses)
bl_dir=""
for d in /sys/class/backlight/*; do [ -d "$d" ] && bl_dir="$d" && break; done
batt_dir=""
for d in /sys/class/power_supply/BAT*; do [ -d "$d" ] && batt_dir="$d" && break; done
adp_dir=""
for d in /sys/class/power_supply/A[CDP]*; do [ -d "$d" ] && adp_dir="$d" && break; done

# volume cache: a pactl subscriber (forked once) re-reads wpctl whenever a
# sink/server/metadata event lands, so the hot loop stays fork-free and volume
# updates feel as immediate as brightness. Cache format: "Volume: 0.53 [MUTED]"
vol_cache="${XDG_RUNTIME_DIR:-/tmp}/swaybar-vol-cache"
write_vol_cache() { wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null > "$vol_cache"; }
write_vol_cache
start_vol_watcher() {
    pactl subscribe 2>/dev/null \
        | grep --line-buffered -E "on (server|sink #|metadata)" \
        | while read -r _; do write_vol_cache; done &
    vol_watch_pid=$!
}
vol_watch_pid=""
if command -v pactl >/dev/null 2>&1; then
    start_vol_watcher
    # reap the subscriber when sway reloads/exits. NOTE: the signal traps
    # must call exit — a handler that returns lets bash resume the loop.
    trap 'pkill -P $$ 2>/dev/null' EXIT
    trap 'exit' INT TERM HUP
fi

SLOW=5   # expensive probes (cpu/ram/disk/wifi) run every N ticks
tick=0

# expensive probes: these fork external tools, so they stay off the fast path
update_system_stats() {
    # cpu
    cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/{print 100 - $8}')
    cpu_usage=$(printf "%.0f"  "$cpu_usage")
    cpu=$(printf "%s %3s%%"  "$cpu_icon" "$cpu_usage")

    # memory
    ram_used=$(free -h  | awk '/Mem:/ {printf "%.1f", $3}')
    ram_total=$(free -h | awk '/Mem:/ {printf "%.1fGB", $2}')
    ram="${ram_icon}  ${ram_used}/${ram_total}"

    # disk (/mnt)
    disk_info=$(df -h /mnt 2>/dev/null | awk 'NR==2{printf "%s/%sB", $3, $2}')
    disk="Main 󰋊 ${disk_info:-N/A}"

    # disk (/mnt)
    disk_info2=$(df -h /media/extra 2>/dev/null | awk 'NR==2{printf "%s/%sB", $3, $2}')
    disk2="Extra 󰋊 ${disk_info2:-N/A}"

    # volume: no pactl subscriber → refresh the cache here (every SLOW
    # ticks); subscriber died (e.g. pipewire restarted) → revive it
    if [ -n "$vol_watch_pid" ]; then
        kill -0 "$vol_watch_pid" 2>/dev/null || { write_vol_cache; start_vol_watcher; }
    else
        write_vol_cache
    fi

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
        wifi="${wifi_icons[$w]}  ${ssid}"
    else
        eth=$(nmcli -t -f TYPE,STATE dev 2>/dev/null | awk -F: '$1=="ethernet" && $2=="connected"{print; exit}')
        if [ -n "$eth" ]; then wifi="󰈀"; else wifi="⚠"; fi
    fi
}

while :; do
    (( tick % SLOW == 0 )) && update_system_stats

    # volume (icon + %) — plain read of the watcher-maintained cache, no
    # subprocess. The regex guards against catching a half-written cache.
    vol=""
    vol_raw=""
    read -r vol_raw < "$vol_cache" 2>/dev/null
    read -r _ vol_lvl vol_rest <<< "$vol_raw"
    if [[ "$vol_lvl" =~ ^[0-9]+\.[0-9][0-9]$ ]]; then
        if [[ "$vol_rest" == *"MUTED"* ]]; then
            vol=$(printf "%s  --%%" "$vol_mute_icon")
        else
            vol_pct=$(( 10#${vol_lvl/./} ))   # "0.53" -> 53 (10# stops 0.08 -> octal)
            if   [ "$vol_pct" -ge 50 ]; then v=2
            elif [ "$vol_pct" -ge 25 ]; then v=1
            else                              v=0; fi
            vol=$(printf "%s %3s%%" "${vol_icons[$v]}" "$vol_pct")
        fi
    fi

    # brightness (icon + %) — sysfs read, no subprocess
    b_cur=0 b_max=0
    [ -n "$bl_dir" ] && { read -r b_cur 2>/dev/null < "$bl_dir/brightness"; read -r b_max 2>/dev/null < "$bl_dir/max_brightness"; }
    b_pct=$(( b_max > 0 ? 100 * b_cur / b_max : 0 ))
    b_idx=$(clamp $(( b_pct / 10 )) 0 9)
    bright=$(printf "%s %3s%%" "${bright_icons[$b_idx]}" "$b_pct")

    # battery (icon + %): bolt icons while on AC. Status alone isn't enough —
    # once the battery tops off, the EC flips "Charging" → "Full"/"Not
    # charging", so key off the AC adapter instead (with a Discharging guard
    # for ECs that report online while the battery is actually draining).
    batt=""
    batt_cap=""
    on_ac=0
    if [ -n "$batt_dir" ]; then
        read -r batt_cap 2>/dev/null < "$batt_dir/capacity"
        read -r batt_state 2>/dev/null < "$batt_dir/status"
    fi
    [ -n "$adp_dir" ] && read -r on_ac 2>/dev/null < "$adp_dir/online"
    if [ -n "$batt_cap" ]; then
        b_idx=$(clamp $(( batt_cap / 10 )) 0 9)
        if [ "$on_ac" = "1" ] && [ "$batt_state" != "Discharging" ]; then
            batt=$(printf "%s %3s%%" "󰚥" "$batt_cap")
        else
            batt=$(printf "%s %3s%%" "${battery_icons[$b_idx]}" "$batt_cap")
        fi
      if [[ "$batt_state" == "Charging" ]]; then
          b_color="#4EC9B0"
      elif   [ "$batt_cap" -ge 50 ]; then b_color="#73C936"
      elif [ "$batt_cap" -ge 25 ]; then b_color="#FFDD33"
      else                               b_color="#F43841"; fi
        batt="<span foreground='${b_color}'>${batt}</span>"
    fi

    # clock
    clock="$(date '+%H:%M')"

    # join segments with a center-dot divider, skipping empty ones (e.g. no battery)
    segments=("${cpu}" "${ram}" "${disk}" "${disk2}" "${wifi}" "${vol}" "${bright}")
    [ -n "$batt" ] && segments+=("${batt}")
    segments+=("${clock}")

    status=""
    for seg in "${segments[@]}"; do
        [ -n "$seg" ] || continue
        [ -n "$status" ] && status+=" · "
        status+="${seg}"
    done
    echo "${status}"

    sleep 1
    (( tick++ ))
done
