#!/bin/bash

# This script is ran to "unfocus" the VM, that is, unbind any input USB devices
# and give up the display from the guest to the host

export DISPLAY=:0

xrandr --output HDMI1 --mode 1920x1080 --rate 75 --rotate left
xrandr --output HDMI2 --mode 1920x1080 --rate 75 --rotate normal --pos 1080x475
xrandr --output VGA1 --mode 1920x1080 --rate 75 --rotate right --pos 3000x0

herbstclient reload

# undo usb passthrough
~/vm/scripts/usb-passthrough.sh del input
xmodmap /home/rasse/.Xmodmap	# reset keyboard layout to normal
xset m 1 1						# reset mouse accel settings to normal
