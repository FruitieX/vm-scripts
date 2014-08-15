#!/bin/bash

# This script is ran on the host OS (by the guest OS) when the guest starts
# shutting down.

export DISPLAY=:0

~/vm/scripts/usb-passthrough.sh del all
#sudo usb-reset.sh				# make sure you have sudo rights to this without password
xrandr --output HDMI1 --mode 1920x1080 --rate 75 --rotate left --pos 0x0
xrandr --output HDMI2 --mode 1920x1080 --rate 75 --rotate normal --pos 1080x475
xrandr --output VGA1 --mode 1920x1080 --rate 75 --rotate right --pos 3000x0
~/bin/wallpaper.sh -o
herbstclient reload
xmodmap /home/rasse/.Xmodmap	# reset keyboard layout to normal
xset m 1 1						# reset mouse accel settings to normal
killall synergyc
exit 0
# pass through usb devices