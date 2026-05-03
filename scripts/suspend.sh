#!/bin/bash

NET_THRESHOLD_KB=1000
DISK_THRESHOLD_KB=5000

while true; do
    if playerctl status 2>/dev/null | grep -q "Playing"; then
        sleep 60
        continue
    fi

    net_start=$(cat /sys/class/net/[ew]*/statistics/*x_bytes 2>/dev/null | awk '{s+=$1} END {print s}')
    disk_start=$(awk '/sd|nvme/ {s+=$6+$10} END {print s}' /proc/diskstats 2>/dev/null)
    net_start=${net_start:-0}
    disk_start=${disk_start:-0}

    sleep 5

    net_end=$(cat /sys/class/net/[ew]*/statistics/*x_bytes 2>/dev/null | awk '{s+=$1} END {print s}')
    disk_end=$(awk '/sd|nvme/ {s+=$6+$10} END {print s}' /proc/diskstats 2>/dev/null)
    net_end=${net_end:-0}
    disk_end=${disk_end:-0}

    net_speed=$(( (net_end - net_start) / 5120 ))
    disk_speed=$(( (disk_end - disk_start) / 10 ))

    if [ "$net_speed" -gt "$NET_THRESHOLD_KB" ] || [ "$disk_speed" -gt "$DISK_THRESHOLD_KB" ]; then
        sleep 60
    else
        systemctl suspend
        exit 0
    fi
done