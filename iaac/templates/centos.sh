#!/bin/sh

dnf upgrade -yq && dnf install -y vim gcc make git


mkdir -p /root/.ssh/
chmod 700 /root/.ssh/
mv -f /root/id_rsa* /root/.ssh/
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod 600 /root/.ssh/*

rm -f /root/centos.sh