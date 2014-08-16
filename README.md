FruitieX' VM scripts
====================

Includes:
* systemd service unit for starting qemu
    * loads its configuration from /etc/conf.d/qemu.d/vmname, see `cfg/` for example
* working configuration for vga passthrough, see following files in `cfg/`:
    * /etc/modprobe.d/vfio_iommu_type1.conf
    * /boot/grub/grub.cfg
    * /usr/bin/vm_init.sh
* various helper scripts for automating useful tasks, see `scripts/`:
    * `usb-passthrough.sh` passes through a set list of usb devices
    * `guest/` directory contains scripts for guest to run at various events
      (guest booted up, guest is shutting down etc)
        * `vm_booted.(sh|bat)` runs on the host `usb-passthrough.sh` on most usb devices at guest bootup
        * `vm_shutdown.(sh|bat)` runs on the host `host/vm_shutdown.sh` on guest shutdown
        * `vm_unfocus.(sh|bat)` turns off the guest's monitor, runs on the host `host/vm_unfocus.sh`, removes mouse/keyboard passthrough to "unfocus" the VM. This causes the monitor to auto-switch to the host, and keyboard/mouse input is redirected to the host as well, effectively "hiding" the guest VM.
    * `host/` directory contains scripts that run on the host's side:
        * `vm_shutdown.sh` remove usb passthrough on all usb devices, reset host monitor configuration
        * `vm_focus.sh` "focuses" the VM by turning off the host's monitor (monitor auto-switches to guest), and passing through mouse/keyboard
        * `vm_unfocus.sh` "unfocuses" the VM by resetting host monitor configuration, removes mouse/keyboard passthrough

VGA passthrough setup:
----------------------
- Host OS: Arch Linux
- Guest OS: Windows 8.1
- CPU: Intel Core i5 4670 3.4 GHz LGA1150
- GPU: Asus Radeon R9 280X DirectCU II TOP 3 GB GDDR5
- Mobo: Asrock Z87M Pro4 Socket LGA 1150

Misc notes:
-----------
- Look inside the cfg directory for files that you may need to modify on your
  system.
- Make sure you use the latest kernel
- Working qemu commit hash: `940973ae0b45c9b6817bab8e4cf4df99a9ef83d7`
