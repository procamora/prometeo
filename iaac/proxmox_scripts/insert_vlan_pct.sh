#!/bin/bash

# set -x

# En principio este meto mas "primitivo" solo se usara con los contenedores health

FILE_VARIABLES="./variables.sh"
source ./variables.sh

my_vmid=$(grep -E "^declare -r VMID_" $FILE_VARIABLES | grep -v "TEMPLATE" | awk -F " " '{print $3}' | tr -d '"')
my_vlans=$(grep -E "^declare -r VLAN_" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"')
my_eth=$(grep -E "^declare -r PCT_ETHERNET" $FILE_VARIABLES | awk -F "=" '{print $2}' | tr -d '"')
my_netmasks=$(grep -E "^declare -r NETMASK_" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"')
my_gateways=$(grep -E "^declare -r GATEWAY_" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"')
my_masks=$(grep -E "^declare -r MASK_" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"')
mapfile -t my_ips < <(grep -E "^declare -r IP_[A-Z]+_HEALTH" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"') # array ips

function centos() {
    ip=$1
    vlan=$2
    mask=$3
    netmask=$4
    gateway=$5

    echo -e '#!/bin/bash\n' >"$MY_PATH/configure_vlan.sh"

    #echo -e 'grep -q "VLAN=yes" /etc/sysconfig/network || echo "VLAN=yes" >> /etc/sysconfig/network\n' >>"$MY_PATH/configure_vlan.sh"

    ifcfg="DEVICE=$my_eth.$vlan
BOOTPROTO=none
ONBOOT=yes
IPADDR=$ip
PREFIX=$mask
#TYPE=Ethernet
VLAN=yes"

    #echo "$ifcfg"
    echo -e "echo \"$ifcfg\" > /etc/sysconfig/network-scripts/ifcfg-$my_eth.$vlan\n" >>"$MY_PATH/configure_vlan.sh"
    echo -e "reboot\n" >>"$MY_PATH/configure_vlan.sh"

    #cat configure_vlan.sh
    pct push "$vmid" "$MY_PATH/configure_vlan.sh" /root/configure_vlan.sh
    echo 'bash /root/configure_vlan.sh' | pct enter "$vmid"
}

function debian() {
    ip=$1
    vlan=$2
    mask=$3
    netmask=$4
    gateway=$5

    echo -e '#!/bin/bash\n' >"$MY_PATH/configure_vlan.sh"

    interfaces="
# custom vlan
auto $my_eth.$vlan
iface $my_eth.$vlan inet static
    address $ip
    netmask $netmask
    gateway $gateway
"

    #echo "$ifcfg"
    echo -e "grep \"iface $my_eth.$vlan inet static\" || echo \"$interfaces\" >> /etc/network/interfaces\n" >>"$MY_PATH/configure_vlan.sh"
    echo -e "reboot\n" >>"$MY_PATH/configure_vlan.sh"

    #cat configure_vlan.sh
    pct push "$vmid" "$MY_PATH/configure_vlan.sh" /root/configure_vlan.sh
    echo 'bash /root/configure_vlan.sh' | pct enter "$vmid"
}

function alpine() {
    # https://wiki.alpinelinux.org/wiki/Vlan
    # config alpine sama as debian
    # FIXME el reboot parece no funcionar con alpine
    debian "$@"
    pct stop "$vmid" && pct start "$vmid"
    #debian "$1" "$2" "$3" "$4" "$5"
}

function foreach_vmids() {
    for vmid_aux in "${my_ips[@]}"; do
        ip=$(echo "$vmid_aux" | awk -F "=" '{print $2}')
        name=$(echo "$vmid_aux" | awk -F "=" '{print $1}' | awk -F "_" '{print $3}')
        zone=$(echo "$vmid_aux" | awk -F "=" '{print $1}' | awk -F "_" '{print $2}')
        vlan=$(echo "$my_vlans" | grep "VLAN_$zone" | awk -F "=" '{print $2}')
        mask=$(echo "$my_masks" | grep "$zone" | awk -F "=" '{print $2}')
        netmask=$(echo "$my_netmasks" | grep "$zone" | awk -F "=" '{print $2}')
        gateway=$(echo "$my_gateways" | grep "$zone" | awk -F "=" '{print $2}')

        vmid=$(echo "$my_vmid" | grep "$zone\_$name" | awk -F "=" '{print $2}')
        debug "[+] $name=>$ip, vmid=$vmid, zone=$zone, vlan=$vlan, mask=$mask, netmask=$netmask"
        test "$vmid" == "" && echo -e "${RED_COLOUR}[-] Error: $name has as vmid: ($vmid).${RESET_COLOUR}" && exit 2

        test "$(pct list | grep "$vmid" | awk '{print $2}')" != "running" && timeout 10 sh -c "(pct start $vmid) 2> /dev/null && sleep 5"

        is_run=$(pct list | grep "$vmid" | awk '{print $2}')
        # if [[ "$is_run" == "running" ]]; then
        if [[ "$is_run" == "running" ]] && [[ "$vlan" != "1" ]]; then
            #os_aux=$(echo "cat /etc/os-release | egrep "^NAME=" | tr -d \"" | pct enter "$vmid")
            os_aux=$(echo "cat /etc/os-release " | pct enter "$vmid")
            #debug "$os_aux"
            os=$(echo "$os_aux" | grep -E "^NAME=" | tr -d \" | awk -F = '{print $NF}' | awk -F " " '{print tolower($1)}')
            debug "|||$os|||"
            debug "|||$gateway|||"
            if [[ "$os" == "$(echo "$PCT_CENTOS" | awk '{print tolower($0)}')" ]]; then
                debug_ok "centos"
                centos "$ip" "$vlan" "$mask" "$netmask" "$gateway"
            elif [ "$os" == "$(echo "$PCT_DEBIAN" | awk '{print tolower($0)}')" ]; then
                debug_ok "debian"
                debian "$ip" "$vlan" "$mask" "$netmask" "$gateway"
            elif [ "$os" == "$(echo "$PCT_ALPINE" | awk '{print tolower($0)}')" ]; then
                debug_ok "alpine"
                debian "$ip" "$vlan" "$mask" "$netmask" "$gateway"
            else
                debug_err "[-] ouch"
            fi
        else
            debug_err "[-] skip $vmid" # skip pct not running
        fi
        echo -e "########################\n\n"
    done
}

foreach_vmids

rm insert_vlan_pct.sh # autoclean
