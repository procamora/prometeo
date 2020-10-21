#!/bin/bash

# set -x

FILE_VARIABLES="./variables.sh"
source ./variables.sh

my_vmid=$(grep -E "^declare -r VMID_" $FILE_VARIABLES | grep -v "TEMPLATE" | awk -F " " '{print $3}' | tr -d '"')
my_vlans=$(grep -E "^declare -r VLAN_" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"')
my_eth=$(grep -E "^declare -r PCT_ETHERNET" $FILE_VARIABLES | awk -F "=" '{print $2}' | tr -d '"')
my_netmasks=$(grep -E "^declare -r NETMASK_" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"')
my_masks=$(grep -E "^declare -r MASK_" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"')
my_ips=($(grep -E "^declare -r IP_" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"'))

function debug() {
    echo -e "${ORANGE_COLOUR}$1${RESET_COLOUR}"
}

function centos() {
    ip=$1
    vlan=$2
    mask=$3
    netmask=$4
    echo -e '#!/bin/bash\n' >"$MY_PATH/configure_vlan.sh"

    echo -e 'grep -q "VLAN=yes" /etc/sysconfig/network || echo "VLAN=yes" >> /etc/sysconfig/network\n' >>"$MY_PATH/configure_vlan.sh"

    ifcfg="DEVICE=$my_eth.$vlan
TYPE=Ethernet
BOOTPROTO=static
ONBOOT=yes
NM_CONTROLED=no
IPADDR=$ip
PREFIX=$mask
VLAN=yes"

    #echo "$ifcfg"
    echo -e "echo \"$ifcfg\" > /etc/sysconfig/network-scripts/ifcfg-$my_eth.$vlan\n" >>"$MY_PATH/configure_vlan.sh"
    echo -e "reboot\n" >>"$MY_PATH/configure_vlan.sh"

    cat configure_vlan.sh
    pct push "$vmid" "$MY_PATH/configure_vlan.sh" /root/configure_vlan.sh
    echo 'bash /root/configure_vlan.sh' | pct enter "$vmid"
}

function debian() {
    ip=$1
    vlan=$2
    mask=$3
    netmask=$4
    echo -e '#!/bin/bash\n' >"$MY_PATH/configure_vlan.sh"

    interfaces="
# custom vlan
auto $my_eth.$vlan
iface $my_eth.$vlan inet static
address $ip
netmask $netmask
"

    #echo "$ifcfg"
    echo -e "grep \"iface $my_eth.$vlan inet static\" || echo \"$interfaces\" >> /etc/network/interfaces\n" >>"$MY_PATH/configure_vlan.sh"
    echo -e "reboot\n" >>"$MY_PATH/configure_vlan.sh"

    cat configure_vlan.sh
    pct push "$vmid" "$MY_PATH/configure_vlan.sh" /root/configure_vlan.sh
    echo 'bash /root/configure_vlan.sh' | pct enter "$vmid"
}

function alpine() {
    #https://wiki.alpinelinux.org/wiki/Vlan
    echo ""
}

# shellcheck disable=SC2120
function foreach_vmids() {
    for vmid_aux in "${my_ips[@]}"; do
        ip=$(echo "$vmid_aux" | awk -F "=" '{print $2}')
        name=$(echo "$vmid_aux" | awk -F "=" '{print $1}' | awk -F "_" '{print $3}')
        zone=$(echo "$vmid_aux" | awk -F "=" '{print $1}' | awk -F "_" '{print $2}')
        vlan=$(echo "$my_vlans" | grep "$zone" | awk -F "=" '{print $2}')
        mask=$(echo "$my_masks" | grep "$zone" | awk -F "=" '{print $2}')
        netmask=$(echo "$my_netmasks" | grep "$zone" | awk -F "=" '{print $2}')

        vmid=$(echo "$my_vmid" | grep "$zone\_$name" | awk -F "=" '{print $2}')
        debug "$name=>$ip, vmid=$vmid, zone=$zone, vlan=$vlan, mask=$mask, netmask=$netmask"

        pct list | grep "$vmid" && pct start "$vmid" && sleep 10

        is_run=$(pct list | grep "$vmid" | awk '{print $2}')
        if [[ "$is_run" == "running" ]]; then
            #os_aux=$(echo "cat /etc/os-release | egrep "^NAME=" | tr -d \"" | pct enter "$vmid")
            os_aux=$(echo "cat /etc/os-release " | pct enter "$vmid")
            #debug "$os_aux"
            os=$(echo "$os_aux" | grep -E "^NAME=" | tr -d \" | awk -F = '{print $NF}' | awk -F " " '{print $1}' | awk '{print tolower($0)}')
            debug "|||$os|||"
            if [[ "$os" == "$(echo "$PCT_CENTOS" | awk '{print tolower($0)}')" ]]; then
                echo "centos"
                centos "$ip" "$vlan" "$mask" "$netmask"
            elif [ "$os" == "$(echo "$PCT_DEBIAN" | awk '{print tolower($0)}')" ]; then
                echo "debian"
                debian "$ip" "$vlan" "$mask" "$netmask"
            else
                debug "ouch"
            fi
        else
            echo "skip $vmid" # skip pct not running
        fi
        echo "########################"
    done
}

foreach_vmids
