#!/bin/bash

if [[ $(whoami) != 'root' ]]; then
	echo "Must run script as root!"
	exit
fi

if [[ $(cat /home/rasse/vm/scripts/.vm_running) == '1' ]]; then
	echo ".vm_running == 1, is vm already running? aborting."
	exit
fi

reset
ulimit -c unlimited

export DISPLAY=:0
echo 1 > /home/rasse/vm/scripts/.vm_running
echo 0 > /home/rasse/vm/scripts/.vm_booted_host.sh_has_been_ran

#echo 3000 > /proc/sys/vm/nr_hugepages
# vfio-bind gpu
vfio-bind 0000:01:00.0 0000:01:00.1
# vfio-bind hda-intel
echo 0000:00:1b.0 > /sys/bus/pci/drivers/snd_hda_intel/unbind
vfio-bind 0000:00:1b.0 0000:00:1b.1

#/home/rasse/vm/scripts/pci-stub-misc.sh

/home/rasse/vm/scripts/qmp-sock.sh &
/home/rasse/vm/scripts/qemu.sh

#echo 0 > /proc/sys/vm/nr_hugepages

echo 0 > /home/rasse/vm/scripts/.vm_running

echo Resetting terminal in 10 seconds, ^C to cancel...
sleep 10
reset							# qemu-monitor messes up the terminal
