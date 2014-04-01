My VM scripts
-------------

VGA passthrough setup:
- Host OS: Arch Linux
- Guest OS: Windows 8.1
- CPU: Intel Core i5 4670 3.4 GHz LGA1150
- GPU: Asus Radeon R9 280X DirectCU II TOP 3 GB GDDR5
- Mobo: Asrock Z87M Pro4 Socket LGA 1150

* Make sure you use the latest kernel
* Working qemu commit hash: `6fc0303b95c873d9e384d7fb51e412ac2e53b9c1`
* Relevant kernel bootup options: `pci-stub.ids=1002:6798,1002:aaa0` `intel_iommu=on`
(Vendor ID / Device ID matches those of GPU and its HDMI audio chip)
