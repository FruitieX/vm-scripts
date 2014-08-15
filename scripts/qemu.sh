export QEMU_AUDIO_DRV=pa
export QEMU_PA_SAMPLES=1024

/home/rasse/src/qemu-latest/x86_64-softmmu/qemu-system-x86_64 \
	-monitor stdio -enable-kvm -M q35 -m 6000 \
	-cpu host,hv-time,hv_relaxed,hv_vapic,hv_spinlocks=0x1000 \
    -balloon virtio \
	-smp 4,sockets=1,cores=4,threads=1 \
	-bios /home/rasse/src/seabios/out/bios.bin \
	-device ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root.1 \
	-device ahci,bus=pcie.0,id=ahci \
	-drive file=/btrfs/vm/win8.raw,id=disk,format=raw,cache=none -device ide-hd,bus=ahci.0,drive=disk \
	-drive file=/btrfs/vm/game.raw,id=game_disk,format=raw,cache=none -device ide-hd,bus=ahci.1,drive=game_disk \
	-drive file=/dev/sdb,id=data_disk,format=raw,cache=none -device ide-hd,bus=ahci.2,drive=data_disk \
    -drive file=/dev/sda,id=ssd_disk,format=raw,cache=none -device virtio-blk-pci,scsi=on,drive=ssd_disk \
	-qmp unix:/home/rasse/vm/qmp-sock,server \
	-device vfio-pci,host=01:00.0,bus=root.1,addr=00.0,multifunction=on,x-vga=on -vga none -nographic \
	-device vfio-pci,host=00:1b.0,bus=root.1,addr=00.1 \
	-usb \
	-device nec-usb-xhci,id=xhci \
	-device ich9-usb-uhci1,id=uhci \
	-netdev bridge,id=bridge,helper=/home/rasse/src/qemu/qemu-bridge-helper \
	-device virtio-net-pci,netdev=bridge,id=pubnet,mac=13:37:12:34:12:34 \
    -netdev user,id=user,hostfwd=tcp::24800-:24800,hostfwd=tcp::3389-:3389 \
    -device virtio-net-pci,netdev=user,id=privnet,mac=13:38:12:34:12:34 \
    -soundhw hda

	#-redir tcp:9999::9999 \
	#-redir tcp:3389::3389 \
	#-device nec-usb-xhci,id=xhci \
	#/home/rasse/src/qemu-latest/x86_64-softmmu/qemu-system-x86_64 -monitor stdio -enable-kvm -M q35 -m 6000 -cpu Haswell,hv-time \
	#-mem-path /dev/hugepages
	#QEMU_PA_SAMPLES=1024 QEMU_AUDIO_DRV=pa
	#-device ich9-intel-hda,bus=pcie.0,addr=1b.0,id=sound0 \
	#-device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 \
#-drive file=/home/rasse/vm/images/install_win81.iso,id=isocd -device ide-cd,bus=ahci.3,drive=isocd -boot menu=on \
#-device pci-assign,host=00:1a.0 \
#-device vfio-pci,host=01:00.1,bus=root.1,addr=00.1 \
