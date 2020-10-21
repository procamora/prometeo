#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen en_US.UTF-8

echo "# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8" >> /root/.bashrc


apt-get -yq update && apt list --upgradable && apt-get -yq upgrade
apt install -y vim git vlan sudo

modprobe 8021q
echo "8021q" >> /etc/modules

mkdir -p /root/.ssh/
chmod 700 /root/.ssh/
mv -f /root/id_rsa* /root/.ssh/
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod 600 /root/.ssh/*

rm -f /root/debian.sh