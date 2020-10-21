#!/bin/bash

source ./variables.sh

#set -x
ENTERPRISE="/etc/apt/sources.list.d/pve-enterprise.list"
test -f $ENTERPRISE && rm -f $ENTERPRISE

apt -y update
apt -y install vim ceph-base ceph-mgr ceph-mon ceph-osd

DEBIAN_FRONTEND=noninteractive apt update -qq </dev/null >/dev/null
DEBIAN_FRONTEND=noninteractive apt upgrade -y -qq </dev/null >/dev/null
DEBIAN_FRONTEND=noninteractive apt install -y -qq vim unzip arp-scan atop </dev/null >/dev/null

# Remove suscription message
sed -i.back "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
systemctl restart pveproxy.service

mkdir -p /root/.ssh
chmod 700 /root/.ssh

mv -f id_rsa /root/.ssh
mv -f id_rsa.pub /root/.ssh
grep -q "root@proxmox" /root/.ssh/authorized_keys || cat /root/.ssh/id_rsa.pub >>/root/.ssh/authorized_keys
chmod 600 /root/.ssh/* # le quitamos los permisos necesarios

function create_users() {
    # Cluster name
    #pvecm create $PM_CNAME --nodeid 1  # FIXME  FALLA, el nombre no es valido

    # if exits config then fail commands
    # Create Pool, Group, User and Permission
    pvesh create pools -poolid "$PM_POOL" --comment "Pool group Prometeo"
    pveum group add "$PM_GROUP" --comment "Group for proyect Prometeo"
    #pveum user add user1@pve --groups "$PM_GROUP" --password "$PM_PASSWORD" --comment "user 1 prometeo"
    #pveum user add user2@pve --groups "$PM_GROUP" --password "$PM_PASSWORD" --comment "user 2 prometeo"
    pveum user add "$PM_USERNAME" --groups "$PM_GROUP" --password "$PM_PASSWORD" --comment "admin prometeo"

    # Creacion del pool dev-prometeo para grupo prometeo con permisos PVEAdmin
    pveum aclmod /pool/"$PM_POOL"/ -group "$PM_GROUP" -role PVEAdmin
    pveum aclmod /pool/"$PM_POOL"/ -group "$PM_GROUP" -role Administrator
}

function create_user_pam() {
    adduser --disabled-password --gecos "" prometeo
    chsh -s "$(which bash)" prometeo
    echo "prometeo:$PM_PASSWORD" | chpasswd
    usermod -a -G root prometeo
    grep -E "^prometeo" /etc/sudoers -q || echo "prometeo    ALL=(ALL:ALL) ALL" >>/etc/sudoers
    # same path that root
    echo 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' >> /home/prometeo/.bashrc
    (echo -e "${GREEN_COLOUR}system reboot in 5 seconds for apply changes...${RESET_COLOUR}" && sleep 5 && reboot) &# becasue finish script
}


# unused becouse terraform need user root
test -f /root/prometeo/apply_basic_config || create_users
test -f /root/prometeo/apply_basic_config || create_user_pam

touch /root/prometeo/apply_basic_config

rm proxmox_configuration.sh # autoclean
