#!/bin/bash
echo 0000:00:1b.0 > /sys/bus/pci/drivers/snd_hda_intel/unbind
echo "8086 8c20" > /sys/bus/pci/drivers/pci-stub/new_id

