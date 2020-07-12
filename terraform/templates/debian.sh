#!/bin/sh


apt update && apt list --upgradable && apt -y upgrade
apt install -y vim git

chmod 600 /root/.ssh/id_rsa*