@echo off

C:
chdir C:\Cygwin\bin

bash --login -i "/cygdrive/x/Apps/vm_unfocus_guest.sh"
"D:\Apps\NirCmd\nircmdc.exe" monitor off
timeout /t 5
"D:\Apps\NirCmd\nircmdc.exe" monitor on
