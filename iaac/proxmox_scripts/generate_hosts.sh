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
    servers_yml="---\n\n# DON'T EDIT, auto-generated file\n# $(date)\n"

    array_groups=("dmz" "lan" "pc")
    for ((i = 0; i < ${#array_groups[@]}; ++i)); do
        inventory+="\n[${array_groups[i]}]\n"
        #servers_yml+="\n${array_groups[i]}:\n"
        #servers_yml+="  hosts:\n"

        mapfile -t array_ips < <(grep -iE "^declare -r IP_${array_groups[i]}" "$vars_files" | grep -v "HEALTH" |
            awk -F " " '{print $3}' | tr -d '"')

        for my_ip in "${array_ips[@]}"; do
            host=$(echo "$my_ip" | awk -F "_" '{print $3}' | awk -F "=" '{print tolower($1)}')
            inventory+="$host.$DOMAIN\n"
            #servers_yml+="    $host.$DOMAIN:\n"
        done
        #servers_yml+="  vars:\n"
        #servers_yml+="    ansible_user: root\n"
        #servers_yml+="    ansible_private_key_file: /root/.ssh/id_rsa\n"
        #servers_yml+="    ansible_python_interpreter: /usr/bin/python3\n"
    done

    # asdasd
    network=$(grep -iE "PCT_NETWORK" "$vars_files" | awk -F "=" '{print $2}' | tr -d '"')
    servers_yml+="\ndefault_interface: $PCT_ETHERNET\n"
    servers_yml+="domain: $DOMAIN\n"
    servers_yml+="network: $network\n"
    servers_yml+="reverse_dns: \"{{ network.split('.')[2] }}.{{ network.split('.')[1] }}.{{ network.split('.')[0] }}.in-addr.arpa\"\n"
    servers_yml+="dns_ext1: 8.8.8.8\n"
    servers_yml+="dns_ext2: 8.8.4.4\n"
    servers_yml+="\nprometeo_user: admin\n"
    servers_yml+="prometeo_pass: $PCT_PASSWORD\n"
    servers_yml+="\ntelegraf_database_influx: telegraf\n"
    servers_yml+="\npath_certificate: \"{{ playbook_dir }}/../../certificates/services\"\n"
    servers_yml+="path_ssl: /etc/pki\n"

    # groups by OS
    mapfile -t my_ips_dmz < <(grep -E "^declare -r IP_(DMZ|IDS|LAN)" "$vars_files" | grep -v "HEALTH" | awk -F " " '{print $3}' | tr -d '"')
    servers_yml+="\nendpoints:\n"
    #servers_yml+="  hosts:\n"
    for my_ip in "${my_ips_dmz[@]}"; do
        host=$(echo "$my_ip" | awk -F "_" '{print $3}' | awk -F "=" '{print tolower($1)}')
        host_ip=$(echo "$my_ip" | awk -F "=" '{print $2}' | tr -d '"')
        proxy=$(grep -iE "PROXY_(DMZ|IDS|LAN)_$host" "$vars_files" | awk -F "=" '{print $2}' | tr -d '"')
        protocol=$(grep -iE "PROTOCOL_(DMZ|IDS|LAN|PC)_$host" "$vars_files" | awk -F "=" '{print $2}' | tr -d '"')
        port=$(grep -iE "PORT_(DMZ|IDS|LAN)_$host" "$vars_files" | awk -F "=" '{print $2}' | tr -d '"')
        servers_yml+="  $host:\n"
        servers_yml+="    service: $host\n"
        servers_yml+="    name: $host.$DOMAIN\n"
        servers_yml+="    port: $port\n"
        servers_yml+="    protocol: $protocol\n"
        servers_yml+="    name_rp: ${host}.rp.${DOMAIN}\n"
        servers_yml+="    ip: $host_ip\n"
        servers_yml+="    rp: $proxy\n"
        servers_yml+="  \n"
    done
    #servers_yml+="  vars:\n"
    #servers_yml+="    ansible_user: root\n"
    #servers_yml+="    ansible_private_key_file: /root/.ssh/id_rsa\n"
    #servers_yml+="    ansible_python_interpreter: /usr/bin/python3\n"

    #echo -e "$servers_yml"
    echo -e "$inventory" >inventory
    echo -e "$servers_yml" >vars_servers.yml
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
