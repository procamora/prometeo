#!/bin/bash

# Remove suscription message
sed -i.back "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
systemctl restart pveproxy.service


mkdir -p /root/.ssh
chmod 700 /root/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDXEcpTAqxQemrkIpEX45ylTLsPhDgko6Qugfv6B1/cioLaeXtI03NgKKMcWv4yMmKMLvJg4adxkEjpn/5IKEA13ljCMZ+Ue29Su+oOYSU8bo3bLlm+h5hvVJeso0irdnrqILNgL4yw38ebmC8IZaKBhiwiGD8sT/LD9VZSqaxnbQ== key used for automation service connections" >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys  # le quitamos los permisos necesarios



# Cluster name
pvecm create $PM_CNAME --nodeid 1 # FIXME revisar que esta bien


# Create Pool, Group, User and Permission
pvesh create pools -poolid $PM_POOL --comment "Pool group Prometeo"
pveum group add $PM_GROUP --comment "Group for proyect Prometeo"
pveum user add user1@pve --groups $PM_GROUP --password 11111 --comment "user 1 prometeo"
pveum user add user2@pve --groups $PM_GROUP --password 11111 --comment "user 2 prometeo"
# Creacion del pool dev-prometeo para grupo prometeo con permisos PVEAdmin
pveum aclmod /pool/$PM_POOL/ -group $PM_GROUP -role PVEAdmin

