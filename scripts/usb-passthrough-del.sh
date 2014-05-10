#!/bin/bash

# This script passes through USB devices one by one to the guest.
# If no arguments are given it passes through a default list of
# USB devices. If any arguments are given, a search for the given
# arguments will be performed and the first match in lsusb will be
# selected.

INFO_USB=$(echo "
{ \"execute\": \"qmp_capabilities\" }
{ \"execute\": \"human-monitor-command\", \"arguments\": { \"command-line\": \"info usb\" }}
" | nc -U /home/rasse/vm/qmp-sock)

# get rid of non printing characters
INFO_USB=$(echo $INFO_USB | tr -dc '[[:print:]]')
# remove some more garbage
INFO_USB=$(echo $INFO_USB | sed 's/{"QMP".*return": " //g')

if [ ! -z "$1" ]
then
	SEARCH=("$@")
else
	SEARCH=(
		"USB Keyboard"
		"Sensei Raw Gaming Mouse"
		"Controller"
		"Akai APC20"
		"CASIO USB-MIDI"
		"CSR8510 Nanosira M2272"
		"USB Receiver"
	)
fi

USB_DEVICES=()
for i in "${SEARCH[@]}"; do
	USB_DEVICES+=($(echo -e " $INFO_USB" | grep "$i" | head -n1 | cut -d" " -f3 | sed 's/,//g'))
done

for i in "${USB_DEVICES[@]}"; do
	echo "Undoing pass through (USB) for $i..."
	echo "
	{ \"execute\": \"qmp_capabilities\" }
	{ \"execute\": \"human-monitor-command\", \"arguments\": { \"command-line\": \"usb_del $i\" }}
	" | nc -U /home/rasse/vm/qmp-sock
	sleep 0.5
done
