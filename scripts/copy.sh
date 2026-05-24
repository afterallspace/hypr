#!/usr/bin/env fish

set flag_file "/tmp/walker_copied_flag"

rm -f $flag_file
pkill -f "wl-paste -w echo walker_trigger"
bash -c 'wl-paste -w echo walker_trigger | awk "NR==2 {print > \"/tmp/walker_copied_flag\"; exit}"' &
walker -m clipboard

set is_open 0
for i in (seq 1 40)
    if hyprctl layers -j | grep -q '"namespace": "walker"'
        set is_open 1
        break
    end
    sleep 0.05
end

if test $is_open -eq 0
    pkill -f "wl-paste -w echo walker_trigger"
    exit 0
end

while hyprctl layers -j | grep -q '"namespace": "walker"'
    sleep 0.05
end

sleep 0.15
if test -f $flag_file
    wtype -M ctrl -k v -m ctrl
end

pkill -f "wl-paste -w echo walker_trigger"
rm -f $flag_file