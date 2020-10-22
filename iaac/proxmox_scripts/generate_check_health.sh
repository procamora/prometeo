#!/bin/bash

FILE_VARIABLES="./variables.sh"
source ./variables.sh


#grep -E '^declare -r IP_[[:alpha:]]+_HEALTH' $FILE_VARIABLES | awk -F ' ' '{print $3}' | tr -d '\"'

# For bash 4.x, must not be in posix mode, may use temporary files
mapfile -t my_ips < <(grep -E "^declare -r IP_[[:alpha:]]+_HEALTH" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"')



function foreach_ips() {
    for ip in "${my_ips[@]}"; do
        name=$(echo "$ip" | awk -F "=" '{print $1}' | awk -F "_" '{print $3}')
        zone=$(echo "$ip" | awk -F "=" '{print $1}' | awk -F "_" '{print $2}')
        addr=$(echo "$ip" | awk -F "=" '{print $2}')

        echo "$name=>$addr, $zone"
    done
}

foreach_ips
