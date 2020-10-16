#!/bin/bash


vmids=$(pct list | awk '{print $1}'| awk '{if(NR>1)print}')

#!/bin/bash
for i in $vmids; do
    echo vmid: "$i"
    pct shutdown "$i"
    pct destroy "$i"
done 


vmids=$(qm list | awk '{print $1}'| awk '{if(NR>1)print}')

#!/bin/bash
for i in $vmids; do
    echo vmid: "$i"
    qm shutdown "$i"
    qm destroy "$i"
done 
