#!/bin/bash

source ./variables.sh

#set -x



DEBIAN_FRONTEND=noninteractive apt update -qq < /dev/null > /dev/null
DEBIAN_FRONTEND=noninteractive apt upgrade -y -qq < /dev/null > /dev/null
DEBIAN_FRONTEND=noninteractive apt install -y -qq vim unzip arp-scan atop < /dev/null > /dev/null

# Remove suscription message
sed -i.back "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
systemctl restart pveproxy.service

mkdir -p /root/.ssh
chmod 700 /root/.ssh

mv -f id_rsa /root/.ssh
mv -f id_rsa.pub /root/.ssh
grep -q "root@proxmox" /root/.ssh/authorized_keys || cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/* # le quitamos los permisos necesarios

function create_users() {
  # Cluster name
  #pvecm create $PM_CNAME --nodeid 1  # FIXME  FALLA, el nombre no es valido

  # if exits config then fail commands
  # Create Pool, Group, User and Permission
  pvesh create pools -poolid "$PM_POOL" --comment "Pool group Prometeo"
  pveum group add "$PM_GROUP" --comment "Group for proyect Prometeo"
  pveum user add user1@pve --groups "$PM_GROUP" --password 11111 --comment "user 1 prometeo"
  pveum user add user2@pve --groups "$PM_GROUP" --password 11111 --comment "user 2 prometeo"
  # Creacion del pool dev-prometeo para grupo prometeo con permisos PVEAdmin
  pveum aclmod /pool/"$PM_POOL"/ -group "$PM_GROUP" -role PVEAdmin
}


test -f /root/prometeo/apply_basic_config || create_users

touch /root/prometeo/apply_basic_config
