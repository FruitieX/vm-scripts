#!/bin/bash

# wait for qemu to start listening on the unix socket
sleep 1

SEARCH=(
"Logitech, Inc. Unifying Receiver"
"Samson Technologies Corp. GoMic compact condenser mic"
)
USB_DEVICES=()

for i in "${SEARCH[@]}"; do
	USB_DEVICES+=($(lsusb | grep "$i" | head -n1 | cut -d" " -f6))
done

for i in "${USB_DEVICES[@]}"; do
vendor=$((0x$(echo $i | cut -d: -f1)))
product=$((0x$(echo $i | cut -d: -f2)))
echo "
{ \"execute\": \"qmp_capabilities\" }
{ \"execute\": \"device_add\", \"arguments\": { \"driver\": \"usb-host\", \"vendorid\": \"$vendor\", \"productid\": \"$product\" }}
" | nc -U /home/rasse/vm/qmp-sock
done
clear
echo -n \(qemu\)\ 
