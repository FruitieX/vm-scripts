#!/bin/bash

if [[ $(whoami) != 'root' ]]; then
	echo "Must run script as root!"
	exit
fi

sudo -u rasse synergyc --crypto-pass $(cat /home/rasse/vm/.synergy_pass) -f localhost:24800 2>&1 > /dev/null &

echo 3000 > /proc/sys/vm/nr_hugepages
/home/rasse/vm/vfio-bind-gpu.sh
/home/rasse/vm/pci-stub-misc.sh

clear

/home/rasse/vm/usb-passthrough-add.sh &
/home/rasse/vm/qemu.sh

xmodmap /home/rasse/.Xmodmap
killall synergyc
reset
