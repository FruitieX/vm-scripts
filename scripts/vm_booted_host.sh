#!/bin/bash

# This script is ran on the host OS (by the guest OS) once the guest has
# finished booting.

if [[ $(cat ~/vm/scripts/.vm_booted_host.sh_has_been_ran) == '1' ]]; then
	echo "error: vm_booted_host.sh already ran after VM was started"
	exit
fi

echo 1 > ~/vm/scripts/.vm_booted_host.sh_has_been_ran
export DISPLAY=:0
# switch to windows display ONLY if HDMI1 is also connected
xrandr | grep "HDMI1 disconnected" > /dev/null 2>&1
if [ $? -ne 0 ]; then
	xrandr --output HDMI2 --off
fi

~/bin/wallpaper.sh -o
herbstclient reload

# pass through usb devices
~/vm/scripts/usb-passthrough.sh add
