#!/bin/bash

# https://pve.proxmox.com/wiki/Linux_Container
# https://pve.proxmox.com/pve-docs/qm.1.html
# https://pve.proxmox.com/pve-docs/pct.1.html

#set -x

find /root/ -name "*.sh" -exec chmod u+x {} \;

# set variables
source ./variables.sh

# update list templates
pveam update

# need sort -r beacuse alpine list is reverse
pveam available --section system | grep alpine | awk '{print $2}' | sort -r | head -n 1 >.name_alpine_ct
TEMPLATE_ALPINE=$(cat ./.name_alpine_ct)
test "$TEMPLATE_ALPINE" || (echo -e "${RED_COLOUR}Missing image alpine :( ${RESET_COLOUR}" && exit 1)
pveam download local "$TEMPLATE_ALPINE" && echo -e "${GREEN_COLOUR}Download image $TEMPLATE_ALPINE${RESET_COLOUR}"

pveam available --section system | grep centos | awk '{print $2}' | sort -r | head -n 1 >./.name_centos_ct
TEMPLATE_CENTOS=$(cat ./.name_centos_ct)
test "$TEMPLATE_CENTOS" || (echo -e "${RED_COLOUR}Missing image centos :( ${RESET_COLOUR}" && exit 1)
pveam download local "$TEMPLATE_CENTOS" && echo -e "${GREEN_COLOUR}Download image $TEMPLATE_CENTOS${RESET_COLOUR}"
#test -f "$MY_PATH/CentOS.qcow2" ||
#    wget https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2 \
#        -O "$MY_PATH/CentOS.qcow2"

pveam available --section system | grep debian | awk '{print $2}' | sort | head -n 1 >./.name_debian_ct
TEMPLATE_DEBIAN=$(cat ./.name_debian_ct)
test "$TEMPLATE_DEBIAN" || (echo -e "${RED_COLOUR}Missing image debian :( ${RESET_COLOUR}" && exit 1)
pveam download local "$TEMPLATE_DEBIAN" && echo -e "${GREEN_COLOUR}Download image $TEMPLATE_DEBIAN${RESET_COLOUR}"

function remove_pct() {
    # destroy execute becasue shutdown failed
    pct list | grep -q "$1" && pct shutdown "$1"
    pct list | grep -q "$1" && pct destroy "$1"
}

function remove_qm() {
    # destroy execute becasue shutdown failed
    qm list | grep -q "$1" && qm shutdown "$1"
    qm list | grep -q "$1" && qm destroy "$1"
}

function ct_create_template_alpine() {
    echo -e "${BLUE_COLOUR}ct_create_template_alpine${RESET_COLOUR}"

    # if exits ct then remove ct
    remove_pct "$VMID_TEMPLATE_ALPINE"

    pct create "$VMID_TEMPLATE_ALPINE" "local:vztmpl/$TEMPLATE_ALPINE" \
        --description "Alpine Container Template" \
        --cores 1 \
        --force 1 \
        --hostname "alpine-template" \
        --memory 1024 \
        --ostype alpine \
        --password "$PASSWORD" \
        --storage "$PM_STORAGE" \
        --pool "$PM_POOL"
    #        --ssh-public-keys /root/.ssh/id_rsa.pub \

    pct set "$VMID_TEMPLATE_ALPINE" -net0 name=eth0,bridge=vmbr0,ip=dhcp
    #pct set "$VMID_TEMPLATE_ALPINE" -hookscript local:snippets/ansible.pl  # template in /usr/share/pve-docs/example/guest-example-hookscript.pl

    pct start "$VMID_TEMPLATE_ALPINE"
    sleep "$TIME_SLEEP"

    pct push "$VMID_TEMPLATE_ALPINE" /root/.ssh/id_rsa /root/id_rsa
    pct push "$VMID_TEMPLATE_ALPINE" /root/.ssh/id_rsa.pub /root/id_rsa.pub
    pct push "$VMID_TEMPLATE_ALPINE" "$MY_PATH/alpine.sh" /root/alpine.sh
    echo 'sh /root/alpine.sh' | pct enter "$VMID_TEMPLATE_ALPINE"

    pct shutdown "$VMID_TEMPLATE_ALPINE"
    pct template "$VMID_TEMPLATE_ALPINE"
}

function ct_create_template_centos() {
    echo -e "${BLUE_COLOUR}ct_create_template_centos${RESET_COLOUR}"

    # if exits ct then remove ct
    remove_pct "$VMID_TEMPLATE_CENTOS"

    #pct create "$VMID_TEMPLATE_CENTOS" "/var/lib/vz/template/cache/$TEMPLATE_DEBIAN" \
    pct create "$VMID_TEMPLATE_CENTOS" "local:vztmpl/$TEMPLATE_CENTOS" \
        --description "CentOS Container Template" \
        --cores 1 \
        --force 1 \
        --hostname "centos-template" \
        --memory 1024 \
        --ostype centos \
        --password "$PASSWORD" \
        --storage "$PM_STORAGE" \
        --pool "$PM_POOL"
    #        --ssh-public-keys /root/.ssh/id_rsa.pub \

    pct set "$VMID_TEMPLATE_CENTOS" -net0 name=eth0,bridge=vmbr0,ip=dhcp
    #pct set "$VMID_TEMPLATE_CENTOS" -hookscript local:snippets/ansible.pl  # template in /usr/share/pve-docs/example/guest-example-hookscript.pl

    pct start "$VMID_TEMPLATE_CENTOS"
    sleep "$TIME_SLEEP"

    pct push "$VMID_TEMPLATE_CENTOS" /root/.ssh/id_rsa /root/id_rsa
    pct push "$VMID_TEMPLATE_CENTOS" /root/.ssh/id_rsa.pub /root/id_rsa.pub
    pct push "$VMID_TEMPLATE_CENTOS" "$MY_PATH/centos.sh" /root/centos.sh
    echo 'sh /root/centos.sh' | pct enter "$VMID_TEMPLATE_CENTOS"

    pct shutdown "$VMID_TEMPLATE_CENTOS"
    pct template "$VMID_TEMPLATE_CENTOS"
}

function ct_create_template_debian() {
    echo -e "${BLUE_COLOUR}ct_create_template_debian${RESET_COLOUR}"

    # if exits ct then remove ct
    remove_pct "$VMID_TEMPLATE_DEBIAN"

    #pct create "$VMID_TEMPLATE_DEBIAN" "/var/lib/vz/template/cache/$TEMPLATE_DEBIAN" \
    pct create "$VMID_TEMPLATE_DEBIAN" "local:vztmpl/$TEMPLATE_DEBIAN" \
        --description "Debian Container Template" \
        --cores 1 \
        --force 1 \
        --hostname "debian-template" \
        --memory 1024 \
        --ostype debian \
        --password "$PASSWORD" \
        --storage "$PM_STORAGE" \
        --pool "$PM_POOL"
    #        --ssh-public-keys /root/.ssh/id_rsa.pub \

    pct set "$VMID_TEMPLATE_DEBIAN" -net0 name=eth0,bridge=vmbr0,ip=dhcp
    #pct set "$VMID_TEMPLATE_DEBIAN" -hookscript local:snippets/ansible.pl  # template in /usr/share/pve-docs/example/guest-example-hookscript.pl

    pct start "$VMID_TEMPLATE_DEBIAN"
    sleep "$TIME_SLEEP"

    pct push "$VMID_TEMPLATE_DEBIAN" /root/.ssh/id_rsa /root/id_rsa
    pct push "$VMID_TEMPLATE_DEBIAN" /root/.ssh/id_rsa.pub /root/id_rsa.pub
    pct push "$VMID_TEMPLATE_DEBIAN" "$MY_PATH/debian.sh" /root/debian.sh
    echo 'sh /root/debian.sh' | pct enter "$VMID_TEMPLATE_DEBIAN"

    pct shutdown "$VMID_TEMPLATE_DEBIAN"
    pct template "$VMID_TEMPLATE_DEBIAN"
}

function ct_create_template_health() {
    echo -e "${BLUE_COLOUR}ct_create_template_health${RESET_COLOUR}"

    # if exits ct then remove ct
    remove_pct "$VMID_TEMPLATE_HEALTH"

    pct clone "$VMID_TEMPLATE_ALPINE" "$VMID_TEMPLATE_HEALTH" \
        --description "Health Container Template" \
        --hostname "health-template" \
        --pool "$PM_POOL"
    # --storage $PM_STORAGE \

    #pct set $VMID_TEMPLATE_HEALTH -net0 name=eth0,bridge=vmbr0,ip=dhcp
    pct start "$VMID_TEMPLATE_HEALTH"
    sleep "$TIME_SLEEP"

    pct push "$VMID_TEMPLATE_HEALTH" "$MY_PATH/health.sh" /root/health.sh
    echo 'sh /root/health.sh' | pct enter "$VMID_TEMPLATE_HEALTH"

    pct shutdown "$VMID_TEMPLATE_HEALTH"
    pct template "$VMID_TEMPLATE_HEALTH"
}

function ct_create_ansible() {
    echo -e "${BLUE_COLOUR}ct_create_ansible${RESET_COLOUR}"

    # if exits ct then remove ct
    remove_pct "$VMID_ANSIBLE"

    pct clone "$VMID_TEMPLATE_DEBIAN" "$VMID_ANSIBLE" \
        --description "Ansible Container Template" \
        --hostname "ansible" \
        --pool "$PM_POOL"
    # --storage $PM_STORAGE \

    #pct set $VMID_ANSIBLE -net0 name=eth0,bridge=vmbr0,ip=dhcp
    pct start "$VMID_ANSIBLE"
    sleep "$TIME_SLEEP"

    pct push "$VMID_ANSIBLE" "$MY_PATH/ansible.sh" /root/ansible.sh
    echo 'sh /root/ansible.sh' | pct enter "$VMID_ANSIBLE"
}

function qm_create_mikrotik() {
    # https://mikrotik.com/download
    # qemu-img convert -O qcow2 /dev/pve/vm-"$VMID_MK"-disk-0 /root/test.qcow2
    echo -e "${BLUE_COLOUR}qm_create_mikrotik${RESET_COLOUR}"

    # if exits ct then remove ct
    remove_qm "$VMID_MK"

    qm create "$VMID_MK" \
        --name mikrotik \
        --net0 virtio,bridge=vmbr0,macaddr="$MAC_WAN_MK" \
        --net1 virtio,bridge=vmbr0 \
        --net2 virtio,bridge=vmbr0 \
        --net3 virtio,bridge=vmbr0 \
        --net4 virtio,bridge=vmbr0 \
        --bootdisk virtio0 \
        --ostype l26 \
        --memory 256 \
        --onboot no \
        --sockets 1 \
        --cores 1

    qm importdisk "$VMID_MK" "$MY_PATH/mikrotik.qcow2" "$PM_STORAGE"
    qm set "$VMID_MK" --virtio0 "$PM_STORAGE:vm-$VMID_MK-disk-0"
    qm set "$VMID_MK" --serial0 socket --vga serial0
    #qm set $VMID_MK --scsihw virtio-scsi-pci --scsi0 $PM_STORAGE:vm-$VMID_MK-disk-0
    qm start "$VMID_MK"
    #sleep 15
    #ip=$(arp-scan -I vmbr0 192.168.1.0/24 | grep -i $MAC_WAN_MK | awk '{print $1}')
    #python3 mk.py $ip
}

ct_create_template_alpine
ct_create_template_centos
ct_create_template_debian
ct_create_template_health
ct_create_ansible
qm_create_mikrotik
