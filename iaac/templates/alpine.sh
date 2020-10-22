#!/bin/sh

# https://wiki.alpinelinux.org/wiki/Writing_Init_Scripts
# https://wiki.alpinelinux.org/wiki/Alpine_Linux_Init_System

apk update && apk upgrade && apk add vim git vlan bash

#modprobe 8021q
#echo "8021q" >> /etc/modules

mkdir -p /root/.ssh/
chmod 700 /root/.ssh/
mv -f /root/id_rsa* /root/.ssh/
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod 600 /root/.ssh/*

rm -f /root/alpine.sh