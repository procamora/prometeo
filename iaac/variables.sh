#!/bin/bash


declare -r MY_PATH="/root/prometeo"

declare -r KEY="$(pwd)/../certificates/openssh/id_rsa"
declare -r SSH="ssh -i $KEY"
declare -r SCP="scp -i $KEY"
declare -r DUMP_PATH="/var/lib/vz/template"

declare -r TIME_SLEEP=10  # pause afer run machine in seconds

#############################################################################################

declare -r PM_HOST="192.168.1.254"
declare -r PM_API_URL="https://192.168.1.254:8006/api2/json"
declare -r PM_CNAME="c.prometeo.01"
declare -r PM_NODE="proxmox"
declare -r PM_POOL="p.prometeo"
declare -r PM_GROUP="g.prometeo"
declare -r PM_STORAGE="local-lvm"
declare -r PM_BRIDGE="vmbr0"
declare -r PM_USERNAME="root@pam"  # system user is "prometeo"
declare -r PM_PASSWORD="password"

#############################################################################################

# VMID TEMPLATES
declare -r VMID_TEMPLATE_ALPINE="4001"
declare -r TEMPLATE_ALPINE_NAME="alpine.tar.gz"

declare -r VMID_TEMPLATE_CENTOS="4002"
declare -r TEMPLATE_CENTOS_NAME="centos.tar.gz"

declare -r VMID_TEMPLATE_DEBIAN="4003"
declare -r TEMPLATE_DEBIAN_NAME="debian.tar.gz"

declare -r VMID_TEMPLATE_HEALTH="4004"
declare -r TEMPLATE_HEALTH_NAME="health.tar.gz"


# VMID EXPECIAL SERVER
declare -r VMID_ANSIBLE="110"
declare -r VMID_MK="111"
declare -r MAC_WAN_MK="4C:5E:0C:BB:8A:01"


# VMID HEALTH SERVERS
declare -r VMID_HEALTH_DMZ="211"
declare -r VMID_HEALTH_LAN="212"
declare -r VMID_HEALTH_PC="213"
declare -r VMID_HEALTH_EXT="214"


# VMID LAN SERVER
declare -r VMID_LAN_ASTERISK="311"
declare -r VMID_LAN_LDAP="312"
declare -r VMID_LAN_ELK="313"
declare -r VMID_LAN_SPLUNK="314"
declare -r VMID_LAN_WINSERVER="315"
declare -r VMID_LAN_OAUTH="316"
declare -r VMID_LAN_OPENID="317"
declare -r VMID_LAN_SQLSERVER="318"


# VMID LAN PCS
declare -r VMID_PC_WIN10="411"
declare -r VMID_PC_WIN7="412"
declare -r VMID_PC_WINXP="413"
declare -r VMID_PC_DEBIAN="414"
declare -r VMID_PC_MACOS="415"


# VMID DMZ SERVERS
declare -r VMID_DMZ_MONGO="511"
declare -r VMID_DMZ_MARIADB="512"
declare -r VMID_DMZ_VSFTPD="513"


# VMID SURICATA
declare -r VMID_MIR_IDS="611"


#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################

#Colours
declare -r BLACK_COLOUR="\e[0;30m"
declare -r RED_COLOUR="\e[0;31m"
declare -r GREEN_COLOUR="\e[0;32m"
declare -r ORANGE_COLOUR="\e[0;33m"
declare -r BLUE_COLOUR="\e[0;34m"
declare -r PURPLE_COLOUR="\e[0;35m"
declare -r CYAN_COLOUR="\e[0;36m"
declare -r WHITE_COLOUR="\e[0;37m"
declare -r RESET_COLOUR="\e[0m"