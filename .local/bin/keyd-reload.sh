#!/bin/bash
notify-send "hi"
if sudo /usr/bin/keyd reload; then
    notify-send "keyd" "Config reloaded ✅"
else
    notify-send -u critical "keyd" "Reload failed ❌"
fi

