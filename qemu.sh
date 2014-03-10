#HUB_BUS=lsusb | grep "4-Port HUB" | cut -d" " -f

/home/rasse/src/qemu/x86_64-softmmu/qemu-system-x86_64 -nographic -monitor stdio -enable-kvm -M q35 -m 6000 -mem-path /dev/hugepages -cpu host \
	-smp 4,sockets=1,cores=4,threads=1 \
	-bios /home/rasse/src/seabios/out/bios.bin -vga none \
	-device ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root.1 \
	-device vfio-pci,host=01:00.0,bus=root.1,addr=00.0,multifunction=on,x-vga=on \
	-device pci-assign,host=00:1b.0 \
	-device ahci,bus=pcie.0,id=ahci \
	-drive file=/home/rasse/vm/win8.raw,id=disk,format=raw -device ide-hd,bus=ahci.0,drive=disk \
	-usb \
	-redir tcp:24800::24800 \
	-qmp unix:/home/rasse/vm/qmp-sock,serve

#	-usb -device usb-host,hostbus=1,hostaddr=21 \
#	-device vfio-pci,host=01:00.1,bus=root.1,addr=00.1 \
