@echo off

C:
chdir C:\Cygwin\bin

bash --login -i "/cygdrive/x/Apps/vm_shutdown.sh"
"D:\Apps\NirCmd\nircmdc.exe" monitor off
shutdown /p /f
