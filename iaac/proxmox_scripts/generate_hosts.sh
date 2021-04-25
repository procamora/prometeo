#!/bin/bash

#DOMAIN="prometeo.com"

# set variables
if [[ -f ./variables.sh  ]]; then
  vars_files="./variables.sh"
  source ./variables.sh
else
  vars_files="../variables.sh"
  source ../variables.sh
fi

mapfile -t my_ips < <(grep -E "^declare -r IP_" "$vars_files" | awk -F " " '{print $3}' | tr -d '"')     # array ips
mapfile -t my_gw < <(grep -E "^declare -r GATEWAY_" "$vars_files" | awk -F " " '{print $3}' | tr -d '"') # array ips

function generate_inventary() {
    inventory="# DON'T EDIT, auto-generated file\n# $(date)\n"
    inventory_yml="# DON'T EDIT, auto-generated file\n# $(date)\n"

    array_groups=("dmz" "lan" "pc")
    for ((i = 0; i < ${#array_groups[@]}; ++i)); do
        inventory+="\n[${array_groups[i]}]\n"
        inventory_yml+="\n${array_groups[i]}:\n"
        inventory_yml+="  hosts:\n"

        mapfile -t array_ips < <(grep -iE "^declare -r IP_${array_groups[i]}" "$vars_files" | grep -v "HEALTH" |
            awk -F " " '{print $3}' | tr -d '"')

        for my_ip in "${array_ips[@]}"; do
            host=$(echo "$my_ip" | awk -F "_" '{print $3}' | awk -F "=" '{print tolower($1)}')
            inventory+="$host.$DOMAIN\n"
            inventory_yml+="    $host.$DOMAIN:\n"
        done
        inventory_yml+="  vars:\n"
        inventory_yml+="    ansible_user: root\n"
        inventory_yml+="    ansible_private_key_file: /root/.ssh/id_rsa\n"
        inventory_yml+="    ansible_python_interpreter: /usr/bin/python3\n"
    done

    # groups by OS
    mapfile -t my_ips_dmz < <(grep -E "^declare -r IP_(DMZ|IDS|LAN)" "$vars_files" | grep -v "HEALTH" | awk -F " " '{print $3}' | tr -d '"')
    inventory_yml+="\nendpoints:\n"
    #inventory_yml+="  hosts:\n"
    for my_ip in "${my_ips_dmz[@]}"; do
        host=$(echo "$my_ip" | awk -F "_" '{print $3}' | awk -F "=" '{print tolower($1)}')
        host_ip=$(echo "$my_ip" | awk -F "=" '{print $2}' | tr -d '"')
        proxy=$(grep -iE "PROXY_(DMZ|IDS|LAN)_$host" "$vars_files" | awk -F "=" '{print $2}' | tr -d '"')
        protocol=$(grep -iE "PROTOCOL_(DMZ|IDS|LAN)_$host" "$vars_files" | awk -F "=" '{print $2}' | tr -d '"')
        port=$(grep -iE "PORT_(DMZ|IDS|LAN)_$host" "$vars_files" | awk -F "=" '{print $2}' | tr -d '"')
        inventory_yml+="  $host:\n"
        inventory_yml+="    service: $host\n"
        inventory_yml+="    name: $host.$DOMAIN\n"
        inventory_yml+="    port: $port\n"
        inventory_yml+="    protocol: $protocol\n"
        inventory_yml+="    name_rp: ${host}.rp.${DOMAIN}\n"
        inventory_yml+="    ip: $host_ip\n"
        inventory_yml+="    rp: $proxy\n"
        inventory_yml+="  \n"
    done
    inventory_yml+="  vars:\n"
    inventory_yml+="    ansible_user: root\n"
    inventory_yml+="    ansible_private_key_file: /root/.ssh/id_rsa\n"
    inventory_yml+="    ansible_python_interpreter: /usr/bin/python3\n"

    #echo -e "$inventory_yml"
    echo -e "$inventory_yml" >inventory.yml
}

function foreach_ips() {
    hosts="# DON'T EDIT, auto-generated file\n# $(date)\n127.0.0.1\tlocalhost localhost.localdomain localhost4 localhost4.localdomain4\n"
    hosts+="::1\t\tlocalhost localhost.localdomain localhost6 localhost6.localdomain6\n\n"

    # mikrotik
    for my_ip in "${my_gw[@]}"; do
        ip=$(echo "$my_ip" | awk -F "=" '{print $NF}')
        host=$(echo "$my_ip" | awk -F "_" '{print $2}' | awk -F "=" '{print tolower($1)}')
        hosts+="$ip\t$host.mk.$DOMAIN\n"
    done
    hosts+="\n"

    # hosts
    for my_ip in "${my_ips[@]}"; do
        ip=$(echo "$my_ip" | awk -F "=" '{print $NF}')
        host=$(echo "$my_ip" | awk -F "_" '{print $3}' | awk -F "=" '{print tolower($1)}')
        hosts+="$ip\t$host.$DOMAIN\n"
    done

    echo -e "$hosts" >hosts
}

foreach_ips
generate_inventary

#rm -f generate_hosts.sh #autoclean
