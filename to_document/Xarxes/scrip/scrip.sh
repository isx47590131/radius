!#/bin/bash
systemctl stop NetworkManager

name_from_fedora_A=enp0s20f0u4
name_from_fedora_B=enp0s26u1u1
name_from_fedora_C=enp0s29u1u5c2

label_A=22
label_B=23
label_C=24

ip link set $name_from_fedora_A down
ip link set $name_from_fedora_B down
ip link set $name_from_fedora_C down

ip link set $name_from_fedora_A name usbA
ip link set $name_from_fedora_B name usbB
ip link set $name_from_fedora_C name usbC

ip link set usbA address aa:aa:aa:00:00:$label_A
ip link set usbB address aa:aa:aa:00:00:$label_B
ip link set usbC address aa:aa:aa:00:00:$label_C

ip link set usbA up
ip link set usbB up
ip link set usbC up
