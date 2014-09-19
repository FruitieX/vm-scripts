#!/bin/bash

# This script passes through USB devices one by one to the guest.
# First argument must be "add" or "delete"

# If no second argument is given it passes through a default list of USB
# devices. If a second argument is given, a search for the given string will be
# performed and the first match in the output of lsusb will be selected.

trap "exit 1" TERM
export TOP_PID=$$

USB_DEVICES=()

if [ ! -z "$2" ]; then
	USB_DEVICES=("$2")
fi

# pass through main mouse and keyboard
if [[ "$2" == "input" || "$2" == "all" ]]; then
    # Ducky Mini
    # Ideazon, Inc. (SteelSeries Sensei RAW)
    USB_DEVICES+=(
        "0f39:0611"
        "1038:1369"
    )
fi

# loop over given search strings
for i in "${USB_DEVICES[@]}"; do
	# loop over results of search string
	(lsusb | grep -i "$i") | while read line; do
		bus=$(echo $line | cut -d" " -f2 | sed 's/^0*//')
		device=$(echo $line | cut -d" " -f4 | sed 's/://' | sed 's/^0*//')
		vendor=$(echo $line | cut -d" " -f6 | cut -d: -f1)
		product=$(echo $line | cut -d" " -f6 | cut -d: -f2)

		guestbus="xhci.0"
		vendorproduct="$vendor:$product"
		#if [[ $vendorproduct == "10f5:0211" || $vendorproduct == "0f39:0611" ]]; then
			# for some reason the qemu xhci code does not like this device
		#	echo "passing to uhci"
		#	guestbus="uhci.0"
		#fi

		if [[ $1 == "add" ]]; then
			echo "Passing through (USB):"
			echo $line
			#vendor=$((0x$(echo $i | cut -d: -f1)))
			#product=$((0x$(echo $i | cut -d: -f2)))
			echo "
			{ \"execute\": \"qmp_capabilities\" }
			{ \"execute\": \"device_add\", \"arguments\": { \"driver\": \"usb-host\", \"hostbus\": \"$bus\", \"hostaddr\": \"$device\", \"id\": \"usb_$vendor.$product.$bus.$device\", \"bus\": \"$guestbus\" }}
			" | nc localhost 4444
			# NOTE: hostbus, hostaddr, hostport could be used here too
			sleep 3 # windows guests hate you if you shove 10 usb devices in at once
		elif [[ $1 == "del" ]]; then
			echo "Undoing passthrough (USB):"
			echo $line
			echo "
			{ \"execute\": \"qmp_capabilities\" }
			{ \"execute\": \"device_del\", \"arguments\": { \"id\": \"usb_$vendor.$product.$bus.$device\" }}
			" | nc localhost 4444
			sleep 0.5
		else
			echo "Unknown command $1! Use either add or del as first argument."
			kill -s TERM $TOP_PID
		fi
	done
done
