#!/bin/sh


export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales


apt update && apt list --upgradable && apt -y upgrade
apt install -y vim git

chmod 600 /root/.ssh/id_rsa*