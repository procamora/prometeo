#!/bin/bash

# https://pve.proxmox.com/wiki/Linux_Container

# set variables
source /root/prometeo/variables.sh

# update list templates
pveam update

ALPINE=$(pveam available | grep "$TEMPLATE_ALPINE" | awk '{ print $2 }')
test ! $ALPINE && echo -e "${RED}missing image alpine :( ${NC}" && exit 1
pveam download local $ALPINE
echo -e "${GREEN}Download image $ALPINE${NC}"
 
CENTOS=$(pveam available | grep "$TEMPLATE_CENTOS" | awk '{ print $2 }')
test ! $CENTOS && echo -e "${RED}missing image alpine :( ${NC}" && exit 1
pveam download local $CENTOS
echo -e "${GREEN}Download image $CENTOS${NC}"
 
#DEBIAN=$(pveam available | grep "$TEMPLATE_DEBIAN" | awk '{ print $2 }')
#test ! $DEBIAN && echo -e "${RED}missing image alpine :( ${NC}" && exit 1
#pveam download local $DEBIAN
#echo -e "${GREEN}Download image $DEBIAN${NC}"



! test -f CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2 && wget https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2

qm list | grep 5000 -q
if [ "$?" -eq "1" ]; then
	qm create 5000 --name centos-cloud-image --memory 4096 --net0 virtio,bridge=vmbr0 --cores 2 --sockets 2 --cpu cputype=kvm64 --description "CentOS cloud-image" --kvm 1 --numa 1
	qm importdisk 5000 CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2 local-lvm
	qm set 5000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-5000-disk-0
	qm set 5000 --ide2 local-lvm:cloudinit
	qm set 5000 --boot c --bootdisk scsi0
	qm set 5000 --serial0 socket --vga serial0
	# Convert to a template
	qm template 5000
fi




