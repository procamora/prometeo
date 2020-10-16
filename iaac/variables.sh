#!/bin/bash



declare -r MY_PATH="/root/prometeo"

declare -r KEY="$(pwd)/../certificates/openssh/id_rsa"
declare -r SSH="ssh -i $KEY"
declare -r SCP="scp -i $KEY"

declare -r TIME_SLEEP=10  # pause afer run machine in seconds

#############################################################################################

declare -r PM_HOST="192.168.1.254"
declare -r PM_CNAME="c.prometeo.01"
declare -r PM_NODE="proxmox"
declare -r PM_POOL="p.prometeo"
declare -r PM_GROUP="g.prometeo"
declare -r PM_STORAGE="local-lvm"
declare -r PASSWORD="password"

#############################################################################################

# VMID TEMPLATES
declare -r VMID_TEMPLATE_ALPINE="4001"
declare -r VMID_TEMPLATE_CENTOS="4002"
declare -r VMID_TEMPLATE_DEBIAN="4003"
declare -r VMID_TEMPLATE_HEALTH="4003"


# VMID HOSTS
declare -r VMID_DB="201"
declare -r VMID_ANSIBLE="501"
declare -r VMID_MK="601"


declare -r MAC_WAN_MK="4C:5E:0C:BB:8A:01"


#Colours
declare -r BLACK_COLOUR='\e[0;30m'
declare -r RED_COLOUR='\e[0;31m'
declare -r GREEN_COLOUR='\e[0;32m'
declare -r ORANGE_COLOUR='\e[0;33m'
declare -r BLUE_COLOUR='\e[0;34m'
declare -r PURPLE_COLOUR='\e[0;35m'
declare -r CYAN_COLOUR='\e[0;36m'
declare -r WHITE_COLOUR='\e[0;37m'
declare -r RESET_COLOUR='\e[0m'