#!/bin/bash

# set variables
source ./variables.sh

find . -name "*.sh" -exec chmod u+x {} \;

# check vmid duplicates in file variables.sh
function check_vmid_duplicates() {
    duplicates_num=$(grep "VMID_" variables.sh | awk -F "=" '{print $2}' | sort | uniq -D | wc -l)
    if [[ "$duplicates_num" == "0" ]]; then
        echo -e "${GREEN_COLOUR}check_vmid_duplicates OK${RESET_COLOUR}"
    else
        echo -e "${RED_COLOUR}ct_create_ansible ERROR${RESET_COLOUR}"
        duplicates=$(grep "VMID_" variables.sh | awk -F "=" '{print $2}' | sort | uniq -D | head -n 1)
        echo -e "${RED_COLOUR}$(grep "$duplicates" variables.sh)${RESET_COLOUR}"
        exit 1
    fi
}

function waiting_online() {
    sleep 20 # need becasue script run thread "sleep 5 && reboot" and reboot is slow
    echo -e "${ORANGE_COLOUR}waiting for Server ${PM_HOST}${RESET_COLOUR}"
    while ! timeout 0.4 ping -c 1 -n "$PM_HOST" &>/dev/null; do
        printf "%c" "."
    done
    echo -e "\n${GREEN_COLOUR}Server is back online ${PM_HOST}${RESET_COLOUR}"
    sleep 5 # fix errors
}

function basic_config_proxmox() {
    # Instalacion de la confiugracion basica en Proxmox
    $SSH root@"$PM_HOST" "mkdir -p $MY_PATH/"
    $SCP proxmox_scripts/initial_configuration.sh "root@$PM_HOST:$MY_PATH/"
    $SCP "$KEY" "root@$PM_HOST:$MY_PATH/"
    $SCP "$KEY.pub" "root@$PM_HOST:$MY_PATH/"
    $SSH root@"$PM_HOST" "cd $MY_PATH && bash initial_configuration.sh"
    waiting_online
}

function create_templates() {
    # Download template container alpine
    $SCP proxmox_scripts/generate_templates.sh "root@$PM_HOST:$MY_PATH/"
    $SCP templates/alpine.sh "root@$PM_HOST:$MY_PATH/"
    $SCP templates/ansible.sh "root@$PM_HOST:$MY_PATH/"
    $SCP templates/centos.sh "root@$PM_HOST:$MY_PATH/"
    $SCP templates/debian.sh "root@$PM_HOST:$MY_PATH/"
    $SCP templates/health.sh "root@$PM_HOST:$MY_PATH/"
    #$SCP mk/mikrotik.qcow2 "root@$PM_HOST:$MY_PATH/"  # FIXME remove comment
    $SSH root@"$PM_HOST" "cd $MY_PATH && bash generate_templates.sh"
}

function create_containers() {
    directory=$1
    plan=$2
    state=$3

    test -d .terraform/ || terraform init

    test -L "$directory/variables.tf" || ln -s "$(pwd)/variables.tf" "$directory/"
    test -L "$directory/provider.tf" || ln -s "$(pwd)/provider.tf" "$directory/"
    #set -x
    terraform validate "./$directory/" -with-deps || exit 1

    #if terraform plan -destroy -state="$state" --out="$plan" -var-file="terraform.tfvars" "./$directory/"; then
    #    terraform apply -state="$state" -auto-approve "$plan"
    #else
    #    debug_err "error in plan destroy"
    #    exit 1
    #fi

    terraform plan -state="$state" --out="$plan" -var-file="terraform.tfvars" "./$directory/"

    terraform apply -lock-timeout=1m -parallelism=4 -state="$state" -auto-approve "$plan"
    #if terraform apply -lock-timeout=1m -parallelism=20 -state="$state" -auto-approve "$plan"; then
    #    $SCP proxmox_scripts/insert_vlan_pct.sh "root@$PM_HOST:$MY_PATH/"
    #    $SSH root@"$PM_HOST" "cd $MY_PATH && bash insert_vlan_pct.sh"
    #fi
}

function clear() {
    #rm -f "*.tfstate"
    #rm -f "*.tfplan"
    #$SCP proxmox_scripts/delete_vm.sh "root@$PM_HOST:$MY_PATH/"
    #$SSH root@"$PM_HOST" "bash $MY_PATH/delete_vm.sh"

    $SCP proxmox_scripts/manage_pct.sh "root@$PM_HOST:$MY_PATH"/
    $SSH "root@$PM_HOST" "cd $MY_PATH && bash manage_pct.sh remove_all"
    #grep "TERRAFORM_STATE_" ./variables.sh | awk -F "=" '{print $NF}' | tr -d '"' | xargs rm -f
    find . -name "*tfstate*" -exec rm -f {} \;
    find . -name "*.tfplan" -exec rm -f {} \;
}

function generate_check_health() {
    $SCP proxmox_scripts/generate_check_health.sh "root@$PM_HOST:$MY_PATH/"
    $SSH root@"$PM_HOST" "cd $MY_PATH && bash generate_check_health.sh"
}

function generate_file_hosts() {
    $SCP proxmox_scripts/generate_hosts.sh "root@$PM_HOST:$MY_PATH/"
    $SSH root@"$PM_HOST" "cd $MY_PATH && bash generate_hosts.sh"
}

function main() {
    check_vmid_duplicates
    $SCP variables.sh "root@$PM_HOST:$MY_PATH/"

    python3 update_variables.py
    generate_file_hosts
    generate_check_health

    #basic_config_proxmox

    #clear

    create_templates

    create_containers "lxc/health" "lxc_health.tfplan" "$TERRAFORM_STATE_HEALTH"
    #create_containers "lxc/ids" "lxc_ids.tfplan" "$TERRAFORM_STATE_IDS"
    #create_containers "lxc/dmz" "lxc_dmz.tfplan" "$TERRAFORM_STATE_DMZ"
    #create_containers "lxc/lan" "lxc_lan.tfplan" "$TERRAFORM_STATE_LAN"

    $SCP proxmox_scripts/insert_vlan_pct.sh "root@$PM_HOST:$MY_PATH/"
    $SSH root@"$PM_HOST" "cd $MY_PATH && bash insert_vlan_pct.sh"
}

main "$@"
