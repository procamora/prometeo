#!/bin/bash

vmids=$(pct list | awk '{print $1}' | awk '{if(NR>1)print}')

#!/bin/bash
for i in $vmids; do
    echo "[+] delete pct vmid: $i"
    timeout 10 sh -c "pct shutdown $i"
    timeout 10 sh -c "pct destroy $i"
done

vmids=$(qm list | awk '{print $1}' | awk '{if(NR>1)print}')

#!/bin/bash
for i in $vmids; do
    echo "[+] delete qm vmid: $i"
    timeout 10 sh -c "qm shutdown $i"
    timeout 10 sh -c "qm destroy $i"
done

# disable autorun because on reboot de machine is offline and is posible remove
find /etc/pve/lxc/ -type f -exec sed -i "s/onboot: 1/onboot: 0/g" {} \;
