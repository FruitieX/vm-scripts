#!/bin/bash

# This script passes through USB devices one by one to the guest.
# If no arguments are given it passes through a default list of
# USB devices. If any arguments are given, a search for the given
# arguments will be performed and the first match in lsusb will be
# selected.

if [ ! -z "$1" ]
then
	USB_DEVICES=($(lsusb | grep "$@" | head -n1 | cut -d" " -f6))
else
	#"Holtek Semiconductor, Inc."
	#"Ideazon, Inc."
	#"Microsoft Corp. Xbox360 Controller"
	#"AKAI"
	#"Casio"
	#"Bluetooth"
	#Ducky mini
	USB_DEVICES=(
		"04d9:0230"
		"1038:1369"
		"045e:028e"
		"09e8:007b"
		"07cf:6803"
		"0a12:0001"
		"0f39:0611"
	)
fi

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
