#!/bin/sh

# https://wiki.alpinelinux.org/wiki/Writing_Init_Scripts
# https://wiki.alpinelinux.org/wiki/Alpine_Linux_Init_System

apk update && apk upgrade && apk add git python3 
git clone https://github.com/procamora/flask-health.git /root/health/
pip3 install -r /root/health/requirements.txt

echo '#!/sbin/openrc-run

name="busybox health"
command="/usr/bin/python3"
command_args="/root/health/health.py"

depend() {
        need net localmount
        after firewall
}' >> /etc/init.d/health

chmod 755 /etc/init.d/health

rc-update add health default

#/etc/init.d/health start

