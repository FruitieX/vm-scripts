#!/bin/bash

# This script passes through USB devices one by one to the guest.
# First argument must be "add" or "delete"

# If no second argument is given it passes through a default list of USB
# devices. If a second argument is given, a search for the given string will be
# performed and the first match in the output of lsusb will be selected.

if [ ! -z "$2" ]
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
	if [[ $1 == "add" ]]; then
		echo "Passing through (USB) $i..."
		echo "
		{ \"execute\": \"qmp_capabilities\" }
		{ \"execute\": \"device_add\", \"arguments\": { \"driver\": \"usb-host\", \"vendorid\": \"$vendor\", \"productid\": \"$product\", \"id\": \"usb_$vendor.$product\" }}
		" | nc -U ~/vm/qmp-sock
		sleep 3 # windows guests hate you if you shove 10 usb devices in at once
	elif [[ $1 == "del" ]]; then
		echo "Undoing passthrough (USB) $i..."
		echo "
		{ \"execute\": \"qmp_capabilities\" }
		{ \"execute\": \"device_del\", \"arguments\": { \"id\": \"usb_$vendor.$product\" }}
		" | nc -U ~/vm/qmp-sock
		sleep 0.5
	else
		echo "Unknown command $1! Use either add or del as first argument."
		exit
	fi
done
