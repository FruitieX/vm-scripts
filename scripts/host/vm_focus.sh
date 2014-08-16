#!/bin/bash

# This script is ran to "focus" the VM, that is, pass through any input USB
# devices and give up the display from the host to the guest

export DISPLAY=:0
# turn off host display input
xrandr --output HDMI2 --off

# passthrough usb input devices
~/vm/scripts/usb-passthrough.sh add input > /dev/null 2>&1
herbstclient reload
