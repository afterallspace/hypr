#!/usr/bin/env bash

CACHE_LINK="/home/afterall/.cache/wallpaper"
HYPRPANEL_STYLE="/home/afterall/.config/hyprpanel/modules.scss"
WALKER_STYLE="/home/afterall/.config/walker/themes/core/style.scss"

if [ -n "$1" ]; then
    IMAGE_PATH=$(realpath "$1")
    
    if [ ! -f "$IMAGE_PATH" ]; then
        echo "Error: File $IMAGE_PATH not found!"
        exit 1
    fi
    
    ln -sf "$IMAGE_PATH" "$CACHE_LINK"
else
    if [ ! -f "$CACHE_LINK" ]; then
        echo "Error: No cached image found and no path provided."
        exit 1
    fi
    IMAGE_PATH=$(realpath "$CACHE_LINK")
fi

echo "Applying theme for: $IMAGE_PATH"

wal -q -i "$IMAGE_PATH"
killall swaybg 2>/dev/null
swaybg -i "$CACHE_LINK" -m fill & disown
touch "$HYPRPANEL_STYLE"
touch "$WALKER_STYLE"

echo "Done! Colors, wallpaper, panel, and terminal updated."