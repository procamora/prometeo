#!/bin/bash

source ./variables.sh

#set -x

ENTERPRISE="/etc/apt/sources.list.d/pve-enterprise.list"
test -f $ENTERPRISE && rm -f $ENTERPRISE

echo "deb http://download.proxmox.com/debian stretch pve-no-subscription" >/etc/apt/sources.list.d/pve-no-subscription.list
wget -O- "http://download.proxmox.com/debian/key.asc" | apt-key add -

DEBIAN_FRONTEND=noninteractive apt update -qq </dev/null >/dev/null
apt list --upgradable
DEBIAN_FRONTEND=noninteractive apt dist-upgrade -y -qq </dev/null >/dev/null
DEBIAN_FRONTEND=noninteractive apt install -y -qq vim unzip arp-scan atop jq axel ceph-base ceph-mgr ceph-mon ceph-osd </dev/null >/dev/null

# Remove suscription message
sed -i.back "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
systemctl restart pveproxy.service

mkdir -p /root/.ssh
chmod 700 /root/.ssh

mv -f id_rsa /root/.ssh
mv -f id_rsa.pub /root/.ssh
grep -q "root@proxmox" /root/.ssh/authorized_keys || cat /root/.ssh/id_rsa.pub >>/root/.ssh/authorized_keys
chmod 600 /root/.ssh/* # le quitamos los permisos necesarios

echo "root:$PM_PASSWORD" | chpasswd

lsmod | grep -q 8021q || modprobe 8021q
grep -q "8021q" /etc/modules || echo "8021q" >>/etc/modules

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
    echo 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' >>/home/prometeo/.bashrc
    (echo -e "${GREEN_COLOUR}system reboot in 5 seconds for apply changes...${RESET_COLOUR}" && sleep 5 && reboot) &# becasue finish script
}

pvesh create /nodes/proxmox/network/ --iface "$PM_BRIDGE_PROMETEO" --type bridge --autostart 1 \
    --comments "Interface Prometeo" --cidr "10.0.0.0/8" --bridge_vlan_aware 1
pvesh create /nodes/proxmox/network/ --iface "$PM_BRIDGE_ISOLATION" --type bridge --autostart 1 \
    --comments "Interface Isolation Labs" --cidr "172.0.0.0/24" --bridge_vlan_aware 1

# unused becouse terraform need user root
test -f /root/prometeo/.apply_basic_config || create_users
test -f /root/prometeo/.apply_basic_config || create_user_pam

touch /root/prometeo/.apply_basic_config

rm initial_configuration.sh # autoclean
