#!/bin/bash

# wait for qemu to start listening on the unix socket
#sleep 1

# let windows boot
#sleep 30

#"Logitech, Inc. Unifying Receiver"
#SEARCH=(
#"Holtek Semiconductor, Inc."
#"Ideazon, Inc."
#"Microsoft Corp. Xbox360 Controller"
#"AKAI"
#"Casio"
#"Bluetooth"
#)
USB_DEVICES=(
"04d9:0230"
"1038:1369"
"045e:028e"
"09e8:007b"
"07cf:6803"
"0a12:0001"
)

#for i in "${SEARCH[@]}"; do
#	USB_DEVICES+=($(lsusb | grep "$i" | head -n1 | cut -d" " -f6))
#done

#{ "execute": "system_powerdown" }
#{ "execute": "human-monitor-command", "arguments": { "command-line": "info usb" } }
for i in "${USB_DEVICES[@]}"; do
	vendor=$((0x$(echo $i | cut -d: -f1)))
	product=$((0x$(echo $i | cut -d: -f2)))
	echo "Passing through (USB) $i..."
	echo "
	{ \"execute\": \"qmp_capabilities\" }
	{ \"execute\": \"device_add\", \"arguments\": { \"driver\": \"usb-host\", \"vendorid\": \"$vendor\", \"productid\": \"$product\" }}
	" | nc -U ~/vm/qmp-sock
	sleep 3 # windows hates you if you shove 10 usb devices in at once
done
#clear
#echo -n \(qemu\)\ 
