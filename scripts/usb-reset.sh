#!/bin/bash
# this script resets all USB3 devices, seems to be necessary sometimes after
# stopping a VM

for i in $(ls /sys/bus/pci/drivers/xhci_hcd/|grep :); do
	echo $i >/sys/bus/pci/drivers/xhci_hcd/unbind
	sleep 0.2
	echo $i >/sys/bus/pci/drivers/xhci_hcd/bind
done
