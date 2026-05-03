#!/usr/bin/env bash

DIR="$HOME/Videos/Recordings"
mkdir -p "$DIR"

FILE="$DIR/rec_$(date +'%Y-%m-%d_%H-%M-%S').mp4"
LOG="/tmp/wl-screenrec.log"

if pgrep -x "wl-screenrec" > /dev/null; then
    killall -SIGINT wl-screenrec
    notify-send -u normal "⏺ Screen Recording" "Successfully saved to $DIR"
else
    notify-send -u critical "⏺ Screen Recording" "Recording started..."
    wl-screenrec -f "$FILE" > "$LOG" 2>&1 &
    disown
fi