#!/bin/bash

# This script is ran on the host OS (by the guest OS) when the guest starts
# shutting down.

export DISPLAY=:0

~/vm/scripts/usb-passthrough.sh del
sudo usb-reset.sh				# make sure you have sudo rights to this without password
xrandr --output HDMI2 --auto --left-of HDMI1
~/bin/wallpaper.sh -o
herbstclient reload
xmodmap /home/rasse/.Xmodmap	# reset keyboard layout to normal
xset m 1 1						# reset mouse accel settings to normal
killall synergyc

# pass through usb devices
