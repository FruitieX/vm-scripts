#!/bin/bash

if [[ $(whoami) != 'root' ]]; then
	echo "Must run script as root!"
	exit
fi

killall -9 synergyc
sudo -u rasse synergyc --crypto-pass $(cat /home/rasse/vm/.synergy_pass) -f localhost:24800 > /dev/null 2>&1 &

echo 3000 > /proc/sys/vm/nr_hugepages
/home/rasse/vm/scripts/vfio-bind-gpu.sh
/home/rasse/vm/scripts/pci-stub-misc.sh

clear

/home/rasse/vm/scripts/usb-passthrough-add.sh &
/home/rasse/vm/scripts/qemu.sh

echo 0 > /proc/sys/vm/nr_hugepages
xmodmap /home/rasse/.Xmodmap
killall synergyc
reset
