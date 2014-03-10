#!/bin/bash

if [[ $(whoami) != 'root' ]]; then
	echo "Must run script as root!"
	exit
fi

echo 3000 > /proc/sys/vm/nr_hugepages
/home/rasse/vm/vfio-bind-gpu.sh
/home/rasse/vm/pci-stub-misc.sh

clear

/home/rasse/vm/usb-passthrough-add.sh &
/home/rasse/vm/qemu.sh

xmodmap /home/rasse/.Xmodmap
reset
