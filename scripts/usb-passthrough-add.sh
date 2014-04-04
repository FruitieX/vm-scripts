#!/bin/bash

# wait for qemu to start listening on the unix socket
sleep 1
echo "
{ \"execute\": \"qmp_capabilities\" }
" | nc -U /home/rasse/vm/qmp-sock

# let windows boot
sleep 30

# switch to windows display
xrandr --output HDMI2 --off
~/bin/wallpaper.sh -o
herbstclient reload

#"Logitech, Inc. Unifying Receiver"
SEARCH=(
"Holtek Semiconductor, Inc."
"Ideazon, Inc."
"Microsoft Corp. Xbox360 Controller"
"AKAI"
"Casio"
"Bluetooth"
)
USB_DEVICES=()

for i in "${SEARCH[@]}"; do
	USB_DEVICES+=($(lsusb | grep "$i" | head -n1 | cut -d" " -f6))
done

#{ "execute": "system_powerdown" }
#{ "execute": "human-monitor-command", "arguments": { "command-line": "info usb" } }
for i in "${USB_DEVICES[@]}"; do
vendor=$((0x$(echo $i | cut -d: -f1)))
product=$((0x$(echo $i | cut -d: -f2)))
echo "Passing through (USB) $i..."
echo "
{ \"execute\": \"qmp_capabilities\" }
{ \"execute\": \"device_add\", \"arguments\": { \"driver\": \"usb-host\", \"vendorid\": \"$vendor\", \"productid\": \"$product\" }}
" | nc -U /home/rasse/vm/qmp-sock
sleep 3
done
clear
echo -n \(qemu\)\ 
