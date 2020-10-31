#!/bin/bash

DOMAIN="prometeo.com"

# set variables
source ./variables.sh

mapfile -t my_ips < <(grep -E "^declare -r IP_" ./variables.sh | awk -F " " '{print $3}' | tr -d '"') # array ips

function foreach_ips() {
    hosts=""
    for my_ip in "${my_ips[@]}"; do
        ip=$(echo "$my_ip" | awk -F "=" '{print $NF}')
        host=$(echo "$my_ip" | awk -F "_" '{print $3}' | awk -F "=" '{print tolower($1)}')
        hosts+="$ip\t$host.$DOMAIN\n"
    done

    echo -e "$hosts" > hosts
}

foreach_ips

rm -f generate_hosts.sh #autoclean