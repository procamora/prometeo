#!/bin/bash

source ./variables.sh

my_vmid=$(grep -E "^declare -r VMID_" ./variables.sh | grep -v "TEMPLATE" | awk -F " " '{print $3}' | tr -d '"')

function start() {
    filter=$1
    mapfile -t vmids < <(echo "$my_vmid" | grep "$filter" | awk -F "=" '{print $2}') # arra vmids
    for vmid in "${vmids[@]}"; do
        test "$(pct list | grep "$vmid" | awk '{print $2}')" != "running" && timeout 10 sh -c "pct start $vmid"
    done
}

function stop() {
    filter=$1
    mapfile -t vmids < <(echo "$my_vmid" | grep "$filter" | awk -F "=" '{print $2}') # arra vmids
    for vmid in "${vmids[@]}"; do
        #echo "$vmid"
        test "$(pct list | grep "$vmid" | awk '{print $2}')" = "running" && timeout 10 sh -c "pct shutdown $vmid"
    done
}

function remove() {
    filter=$1
    mapfile -t vmids < <(echo "$my_vmid" | grep "$filter" | awk -F "=" '{print $2}') # arra vmids
    for vmid in "${vmids[@]}"; do
        #echo "$vmid"
        test "$(pct list | grep "$vmid" | awk '{print $2}')" = "running" && timeout 10 sh -c "pct shutdown $vmid"
        test "$(pct list | grep "$vmid" | awk '{print $2}')" = "stopped" && timeout 10 sh -c "pct destroy $vmid"
    done
}

function print_help() {
    PROGRAM=$(echo "$0" | tr -d './' | tr -d '.sh')
    PROGRAM=$(echo "$0" | awk -F "./" '{print $NF}' | tr -d '.sh')

    echo -e "\n${PURPLE_COLOUR}${PROGRAM} v1.0 (Source: https://github.com/procamora/prometeo)${RESET_COLOUR}"
    echo -e "\n${ORANGE_COLOUR}[*] Use: ./${PROGRAM}.sh OPTION${RESET_COLOUR}"
    echo -e "\n${ORANGE_COLOUR}[*] List of available options:${RESET_COLOUR}"
    echo -e "\t${GREEN_COLOUR}start_all${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}start_dmz${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}start_health${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}start_lan${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}start_ids${RESET_COLOUR}\t\t "

    echo -e "\t${GREEN_COLOUR}stop_all${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}stop_dmz${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}stop_health${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}stop_lan${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}stop_ids${RESET_COLOUR}\t\t "

    echo -e "\t${GREEN_COLOUR}remove_all${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}remove_dmz${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}remove_health${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}remove_lan${RESET_COLOUR}\t\t "
    echo -e "\t${GREEN_COLOUR}remove_ids${RESET_COLOUR}\t\t "

    echo -e "\n\n${BLUE_COLOUR}Example: ./${PROGRAM}.sh start_health${RESET_COLOUR}\n"

    #tput cnorm
    exit 1
}

function main() {
    #tput civis

    VALID_ARGUMENT="False" # Usado para detectar si se ha puesto un argumento valido

    if [[ "$1" == "" ]]; then
        echo "print_help"

    elif [[ "$1" == "start_all" ]]; then
        filter=""
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        start "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "start_dmz" ]]; then
        filter="_DMZ_"
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        start "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "start_health" ]]; then
        filter="_HEALTH="
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        start "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "start_lan" ]]; then
        filter="_LAN_"
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        start "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "start_ids" ]]; then
        filter="_IDS_"
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        start "$filter"
        VALID_ARGUMENT="True"

    #####################################
    elif [[ "$1" == "stop_all" ]]; then
        filter=""
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        stop "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "stop_dmz" ]]; then
        filter="_DMZ_"
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        stop "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "stop_health" ]]; then
        filter="_HEALTH="
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        stop "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "stop_lan" ]]; then
        filter="_LAN_"
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        stop "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "stop_ids" ]]; then
        filter="_IDS_"
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        stop "$filter"
        VALID_ARGUMENT="True"

    #####################################
    elif [[ "$1" == "remove_all" ]]; then
        filter=""
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        remove "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "remove_dmz" ]]; then
        filter="_DMZ_"
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        remove "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "remove_health" ]]; then
        filter="_HEALTH="
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        remove "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "remove_lan" ]]; then
        filter="_LAN_"
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        remove "$filter"
        VALID_ARGUMENT="True"

    elif [[ "$1" == "remove_ids" ]]; then
        filter="_IDS_"
        echo "$1 $(echo "$my_vmid" | grep -c "$filter") containers"
        remove "$filter"
        VALID_ARGUMENT="True"
    #else
    #    echo "ELSE"
    fi

    test "$VALID_ARGUMENT" = "False" && print_help
    exit 0
}

main "$@"
