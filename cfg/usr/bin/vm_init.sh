#!/bin/bash

vfio-bind() {
    modprobe vfio-pci
    for dev in "$@"; do
            vendor=$(cat /sys/bus/pci/devices/$dev/vendor)
            device=$(cat /sys/bus/pci/devices/$dev/device)
            if [ -e /sys/bus/pci/devices/$dev/driver ]; then
                    echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
            fi
            echo $vendor $device > /sys/bus/pci/drivers/vfio-pci/new_id
    done
}

# vfio-bind gpu
vfio-bind 0000:01:00.0 0000:01:00.1

# vfio-bind hda-intel
#echo 0000:00:1b.0 > /sys/bus/pci/drivers/snd_hda_intel/unbind
#vfio-bind 0000:00:1b.0 0000:00:1b.1
