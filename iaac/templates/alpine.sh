#!/bin/sh

# https://wiki.alpinelinux.org/wiki/Writing_Init_Scripts
# https://wiki.alpinelinux.org/wiki/Alpine_Linux_Init_System

apk update && apk upgrade && apk add vim git vlan bash

#modprobe 8021q
#echo "8021q" >> /etc/modules

mv -f /sbin/reboot /sbin/reboot_original
echo "#!/bin/sh
/bin/busybox reboot -f" >/sbin/reboot
chmod +x /sbin/reboot

mv -f /sbin/poweroff /sbin/poweroff_original
echo "#!/bin/sh
/bin/busybox poweroff -f" >/sbin/poweroff
chmod +x /sbin/poweroff

mv -f /sbin/halt /sbin/halt_original
echo "#!/bin/sh
/bin/busybox poweroff -f" >/sbin/halt
chmod +x /sbin/halt

mkdir -p /root/.ssh/
chmod 700 /root/.ssh/
mv -f /root/id_rsa* /root/.ssh/
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod 600 /root/.ssh/*

rm -f /root/alpine.sh
