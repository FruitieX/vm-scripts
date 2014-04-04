@echo off

C:
chdir C:\Cygwin\bin

bash --login -i "/cygdrive/x/Apps/vm_shutdown_guest.sh"
shutdown /p /f
