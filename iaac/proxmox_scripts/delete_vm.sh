#!/bin/bash

EXCLUDE_PCT="template|ansible"
vmids=$(pct list | grep -Ev "$EXCLUDE_PCT" | awk '{if(NR>1)print $1}')

for i in $vmids; do
    echo "[+] delete pct vmid: $i"
    timeout 10 sh -c "pct shutdown $i"
    timeout 10 sh -c "pct destroy $i"
done

vmids=$(qm list | grep -Ev "template|mikrotik" | awk '{if(NR>1)print $1}')

for i in $vmids; do
    echo "[+] delete qm vmid: $i"
    timeout 10 sh -c "qm shutdown $i"
    timeout 10 sh -c "qm destroy $i"
done

# disable autorun because on reboot de machine is offline and is posible remove
find /etc/pve/lxc/ -type f -exec sed -i "s/onboot: 1/onboot: 0/g" {} \;
test "$(pct list | grep -Ecv "$EXCLUDE_PCT")" == "1" || reboot # 1 becasue row headers
