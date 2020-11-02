#!/bin/bash

# set variables
source ./variables.sh

function install() {
    pct start "$VMID_LAN_ANSIBLE" 2>/dev/null
    sleep "$TIME_SLEEP"

    pct push "$VMID_LAN_ANSIBLE" "$MY_PATH/ansible.tar" /root/ansible.tar
    pct push "$VMID_LAN_ANSIBLE" "$MY_PATH/inventory" /root/inventory
    pct push "$VMID_LAN_ANSIBLE" "$MY_PATH/inventory.yml" /root/inventory.yml
    pct push "$VMID_LAN_ANSIBLE" "$MY_PATH/ansible.sh" /root/ansible.sh
    echo 'sh /root/ansible.sh' | pct enter "$VMID_LAN_ANSIBLE"
}

install
