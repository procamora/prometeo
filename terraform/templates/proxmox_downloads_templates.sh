#!/bin/bash

# https://pve.proxmox.com/wiki/Linux_Container
# https://pve.proxmox.com/pve-docs/qm.1.html
# https://pve.proxmox.com/pve-docs/pct.1.html


find /root/ -name "*.sh" -exec chmod u+x {} \;

# set variables
source /root/prometeo/variables.sh

# update list templates
pveam update

ALPINE=$(pveam available --section system | grep "$TEMPLATE_ALPINE" | awk '{ print $2 }')
test ! $ALPINE && echo -e "${RED}missing image alpine :( ${NC}" && exit 1
pveam download local $ALPINE
echo -e "${GREEN}Download image $ALPINE${NC}"
 
#CENTOS=$(pveam available --section system | grep "$TEMPLATE_CENTOS" | awk '{ print $2 }')
#test ! $CENTOS && echo -e "${RED}missing image centos :( ${NC}" && exit 1
#pveam download local $CENTOS
#echo -e "${GREEN}Download image $CENTOS${NC}"
 
DEBIAN=$(pveam available --section system | grep "$TEMPLATE_DEBIAN" | awk '{ print $2 }')
test ! $DEBIAN && echo -e "${RED}missing image debian :( ${NC}" && exit 1
pveam download local $DEBIAN
echo -e "${GREEN}Download image $DEBIAN${NC}"



! test -f /root/prometeo/CentOS-8.qcow2 && \
 wget https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2 \
 -O /root/prometeo/CentOS-8.qcow2




#  --ostype <l24 | l26 | other | solaris | w2k | w2k3 | w2k8 | win10 | win7 | win8 | wvista | wxp> 
function create_template_vm_centos() {
    qm create $VMID_TEMPLATE_CENTOS \
     --name centos-template \
     --description "CentOS 8 KVM Template" \
     --net0 virtio,bridge=vmbr0 \
     --cores 2 \
     --sockets 2 \
     --memory 4096 \
     --cpu cputype=kvm64 \
     --ostype l26 \
     --kvm 1 \
     --agent 1 \
     --numa 1
    
    qm importdisk $VMID_TEMPLATE_CENTOS /root/prometeo/CentOS-8.qcow2 local-lvm
    qm set $VMID_TEMPLATE_CENTOS --scsihw virtio-scsi-pci --scsi0 $PM_STORAGE:vm-$VMID_TEMPLATE_CENTOS-disk-0
    qm set $VMID_TEMPLATE_CENTOS --ide2 local-lvm:cloudinit
    qm set $VMID_TEMPLATE_CENTOS --boot c --bootdisk scsi0
    qm set $VMID_TEMPLATE_CENTOS --serial0 socket --vga serial0
    qm set $VMID_TEMPLATE_CENTOS --ciuser root
    qm set $VMID_TEMPLATE_CENTOS --cipassword toor
    qm set $VMID_TEMPLATE_CENTOS --nameserver 1.1.1.1
    qm set $VMID_TEMPLATE_CENTOS --ipconfig0 ip=dhcp
    qm set $VMID_TEMPLATE_CENTOS --sshkey ~/.ssh/id_rsa.pub

    qm start $VMID_TEMPLATE_CENTOS


    #ssh -o StrictHostKeyChecking=no root@10.1.2.123
    
    #qm stop $VMID_TEMPLATE_CENTOS
    #qm wait $VMID_TEMPLATE_CENTOS
    # Convert to a template
    #qm template $VMID_TEMPLATE_CENTOS
}



function create_vm_db() {
    qm clone $VMID_TEMPLATE_CENTOS $VMID_DB --name databases

    qm set $VMID_DB --description "CentOS Databases"
    qm set $VMID_DB --cores 1
    qm set $VMID_DB --sockets 1
    qm set $VMID_DB --memory 1024
    qm set $VMID_DB --net0 virtio,bridge=vmbr2
    #qm set $VMID_DB --ciuser root
    #qm set $VMID_DB --cipassword toor
    qm set $VMID_DB --ipconfig0 ip=10.1.2.124/24,gw=10.1.2.254
    #qm set $VMID_DB --sshkey ~/.ssh/id_rsa.pub

    qm start $VMID_DB

}


function create_template_ct_debian() {
    pct create $VMID_TEMPLATE_DEBIAN local:vztmpl/$TEMPLATE_DEBIAN \
     --description "Debian Container Template" \
     --cores 2 \
     --force 1 \
     --hostname "debian10" \
     --memory 2048 \
     --ostype debian \
     --password password \
     --storage $PM_STORAGE \
     --ssh-public-keys /root/.ssh/id_rsa.pub \
     --pool $PM_POOL


    pct set $VMID_TEMPLATE_DEBIAN -net0 name=eth0,bridge=vmbr0,ip=dhcp
    #pct set $VMID_TEMPLATE_DEBIAN -hookscript local:snippets/ansible.pl  # template in /usr/share/pve-docs/example/guest-example-hookscript.pl

    pct start $VMID_TEMPLATE_DEBIAN
    sleep 5

    #echo 'mkdir -p /root/.ssh/ && chmod 700 /root/.ssh/' | pct enter $VMID_TEMPLATE_DEBIAN
    pct push $VMID_TEMPLATE_DEBIAN /root/.ssh/id_rsa /root/.ssh/id_rsa
    pct push $VMID_TEMPLATE_DEBIAN /root/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
    pct push $VMID_TEMPLATE_DEBIAN /root/prometeo/debian.sh /root/debian.sh
    echo 'sh /root/debian.sh' | pct enter $VMID_TEMPLATE_DEBIAN

    pct shutdown $VMID_TEMPLATE_DEBIAN
    pct template $VMID_TEMPLATE_DEBIAN
}




function create_ct_ansible() {
    pct clone $VMID_TEMPLATE_DEBIAN $VMID_ANSIBLE \
     --description "Debian Container Template" \
     --hostname "ansible" \
     --pool $PM_POOL
    # --storage $PM_STORAGE \


    pct start $VMID_ANSIBLE
    sleep 5
    pct push $VMID_ANSIBLE /root/prometeo/debian.sh /root/debian.sh
    echo 'sh /root/ansible.sh' | pct enter $VMID_ANSIBLE

}




qm list | grep $VMID_TEMPLATE_CENTOS -q
if [ "$?" -eq "1" ]; then
    create_template_vm_centos
fi

qm list | grep $VMID_DB -q
if [ "$?" -eq "1" ]; then
    create_vm_db
fi

qm list | grep $VMID_TEMPLATE_DEBIAN -q
if [ "$?" -eq "1" ]; then
    create_template_ct_debian
fi


qm list | grep $VMID_ANSIBLE -q
if [ "$?" -eq "1" ]; then
    create_ct_ansible
fi

