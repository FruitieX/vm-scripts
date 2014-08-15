@echo off

C:
chdir C:\Cygwin\bin

"D:\Apps\NirCmd\nircmdc.exe" monitor off
bash --login -i "/cygdrive/x/Apps/vm_unfocus.sh"
"D:\Apps\NirCmd\nircmdc.exe" monitor off
timeout /t 5
"D:\Apps\NirCmd\nircmdc.exe" monitor on
