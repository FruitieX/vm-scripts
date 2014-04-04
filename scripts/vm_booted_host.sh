#!/bin/bash

# This script is ran on the host OS (by the guest OS) once the guest has
# finished booting.

export DISPLAY=:0
# switch to windows display
xrandr --output HDMI2 --off
~/bin/wallpaper.sh -o
herbstclient reload

# pass through usb devices
~/vm/scripts/usb-passthrough-add.sh
