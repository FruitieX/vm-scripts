QEMU_PA_SAMPLES=900 QEMU_AUDIO_DRV=pa /home/rasse/src/qemu/x86_64-softmmu/qemu-system-x86_64 -monitor stdio -enable-kvm -M q35 -m 6000 -mem-path /dev/hugepages -cpu host \
	-smp 4,sockets=1,cores=4,threads=1 \
	-bios /home/rasse/src/seabios/out/bios.bin \
	-device ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root.1 \
	-device pci-assign,host=00:1b.0 \
	-device vfio-pci,host=01:00.0,bus=root.1,addr=00.0,multifunction=on,x-vga=on -vga none -nographic \
	-device ahci,bus=pcie.0,id=ahci \
	-device ich9-intel-hda,bus=pcie.0,addr=1b.0,id=sound0 \
	-device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 \
	-drive file=/dev/sdb4,id=disk,format=raw -device ide-hd,bus=ahci.0,drive=disk \
	-usb \
	-redir tcp:24800::24800 \
	-qmp unix:/home/rasse/vm/qmp-sock,server

#-device vfio-pci,host=01:00.1,bus=root.1,addr=00.1 \
#-drive file=/home/rasse/vm/win.iso,id=isocd -device ide-cd,bus=ahci.1,drive=isocd -boot menu=on \
