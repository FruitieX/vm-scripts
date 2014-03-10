#!/bin/bash

sudo sh -c "echo 3500 > /proc/sys/vm/nr_hugepages"
sudo ~/vm/vfio-bind-gpu.sh
sudo ~/vm/pci-stub-misc.sh

clear

sudo ~/vm/qemu.sh

xmodmap ~/.Xmodmap
reset
