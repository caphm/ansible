#!/bin/bash

vmname="win10"

qemu-system-x86_64\
  -name win10,process=win10 \
  -machine type=pc,accel=kvm\
  -enable-kvm\
  -cpu host,kvm=off \
  -smp 2,sockets=1,cores=2,threads=1 \
  -m 4G\
  -mem-prealloc \
  -balloon none \
  -rtc clock=host,base=localtime \
  -vga none\
  -display none\
  -nodefconfig\
  -boot order=dc\
  -drive id=disk0,if=virtio,cache=none,format=qcow2,file=/home/caphm/vdisks/win10.qcow2 \
  -drive file=/mnt/storage/ISOs/win10.iso,media=cdrom \
  -drive file=/opt/virtio-win/virtio-win-0.1.141.iso,media=cdrom \
  -usb -usbdevice host:1267:0103 -usbdevice host:046d:c077 \
  -device vfio-pci,host=00:02.0,addr=02.0,bus=pci.0,x-vga=on\
  -chardev stdio,id=seabios\
  -device isa-debugcon,iobase=0x402,chardev=seabios\
  -netdev type=tap,id=net0,ifname=tap0,vhost=on \
  -device virtio-net-pci,netdev=net0,mac=44:8a:5b:a3:92:8f\
&>/var/log/qemuvm.log

exit 0