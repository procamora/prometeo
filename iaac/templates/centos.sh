#!/bin/bash

dnf upgrade -yq
dnf install -y epel-release
dnf install -y vim gcc make git sudo python3 python3-pip python3-argcomplete bash-completion tar openssh-server wget curl unzip

command -v pip >/dev/null || ln -s $(command -v pip3) /usr/bin/pip

#modprobe 8021q
#grep "8021q" /etc/modules || echo "8021q" >> /etc/modules

echo '# disable ipv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1' >>/etc/sysctl.conf

sudo activate-global-python-argcomplete3

ssh-keygen -A

#systemctl stop NetworkManager
#systemctl disable NetworkManager
#dnf -y remove NetworkManager NetworkManager-libnm NetworkManager-team NetworkManager-tui NetworkManager-wifi

mkdir -p /root/.ssh/
chmod 700 /root/.ssh/
mv -f /root/id_rsa* /root/.ssh/
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod 600 /root/.ssh/*

rm -f /root/centos.sh
