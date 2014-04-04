#!/bin/bash

export DISPLAY=:0
# switch to windows display
xrandr --output HDMI2 --off
~/bin/wallpaper.sh -o
herbstclient reload

# pass through usb devices
~/vm/scripts/usb-passthrough-add.sh
