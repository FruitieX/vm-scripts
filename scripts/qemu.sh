/home/rasse/src/qemu/x86_64-softmmu/qemu-system-x86_64 -monitor stdio -enable-kvm -M q35 -m 6000 -cpu Haswell,hv-time \
	-smp 4,sockets=1,cores=4,threads=1 \
	-bios /home/rasse/src/seabios/out/bios.bin \
	-device ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,chassis=1,id=root.1 \
	-device pci-assign,host=00:1b.0 \
	-device ahci,bus=pcie.0,id=ahci \
	-drive file=/home/rasse/vm/images/win8.qcow2,id=disk,format=qcow2 -device ide-hd,bus=ahci.0,drive=disk \
	-drive file=/home/rasse/vm/images/game.qcow2,id=game_disk,format=qcow2 -device ide-hd,bus=ahci.1,drive=game_disk \
	-drive file=/dev/sdb,id=data_disk,format=raw -device ide-hd,bus=ahci.2,drive=data_disk \
	-redir tcp:24800::24800 \
	-redir tcp:9999::9999 \
	-qmp unix:/home/rasse/vm/qmp-sock,server \
	-device vfio-pci,host=01:00.0,bus=root.1,addr=00.0,multifunction=on,x-vga=on -vga none -nographic \
	-usb \

	#-mem-path /dev/hugepages
	#QEMU_PA_SAMPLES=1024 QEMU_AUDIO_DRV=pa
	#-device ich9-intel-hda,bus=pcie.0,addr=1b.0,id=sound0 \
	#-device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 \
#-drive file=/home/rasse/vm/images/install_win81.iso,id=isocd -device ide-cd,bus=ahci.3,drive=isocd -boot menu=on \
#-device pci-assign,host=00:1a.0 \
#-device vfio-pci,host=01:00.1,bus=root.1,addr=00.1 \
