#!/bin/bash

# shellcheck disable=SC2034

declare -r MY_PATH="/root/prometeo"

declare -r KEY="$(pwd)/../certificates/openssh/id_rsa"
declare -r SSH="ssh -i $KEY"
declare -r SCP="scp -i $KEY"
declare -r DUMP_PATH="/var/lib/vz/template"

declare -r TIME_SLEEP=10 # pause afer run machine in seconds

declare -r TERRAFORM_STATE=".myterraform.tfstate"

#############################################################################################

declare -r PM_HOST="192.168.1.254"
declare -r PM_API_URL="https://192.168.1.254:8006/api2/json"
declare -r PM_CNAME="c.prometeo.01"
declare -r PM_NODE="proxmox"
declare -r PM_POOL="p.prometeo"
declare -r PM_GROUP="g.prometeo"
declare -r PM_STORAGE="local-lvm"
declare -r PM_BRIDGE="vmbr0"
declare -r PM_USERNAME="root@pam" # system user is "root"
declare -r PM_PASSWORD="password"

declare -r PCT_ALPINE="alpine"
declare -r PCT_DEBIAN="debian"
declare -r PCT_CENTOS="centos"

declare -r PCT_ETHERNET="eth0"
declare -r PCT_IP_UNICAST="172.16.0.100/32"

#############################################################################################

# VMID TEMPLATES
declare -r VMID_TEMPLATE_ALPINE="4001"
declare -r TEMPLATE_ALPINE_NAME="alpine.tar.gz"

declare -r VMID_TEMPLATE_CENTOS="4002"
declare -r TEMPLATE_CENTOS_NAME="centos.tar.gz"

declare -r VMID_TEMPLATE_DEBIAN="4003"
declare -r TEMPLATE_DEBIAN_NAME="debian.tar.gz"
# declare -r TEMPLATE_DEBIAN_ORIGINAL_NAME="debian_original.tar.gz"

declare -r VMID_TEMPLATE_HEALTH="4004"
declare -r TEMPLATE_HEALTH_NAME="health.tar.gz"

# VMID EXPECIAL SERVER
declare -r VMID_ANSIBLE="110"
declare -r VMID_MK="111"
declare -r MAC_WAN_MK="4C:5E:0C:BB:8A:01"

# VMID HEALTH SERVERS
declare -r VMID_DMZ_HEALTH="221"
declare -r IP_DMZ_HEALTH="10.20.0.254"
declare -r VMID_LAN_HEALTH="222"
declare -r IP_LAN_HEALTH="10.10.0.254"
declare -r VMID_PC_HEALTH="223"
declare -r IP_PC_HEALTH="10.10.11.254"
declare -r VMID_IDS_HEALTH="224"
declare -r IP_IDS_HEALTH="10.30.0.3"
declare -r VMID_LAB_HEALTH="225"
declare -r IP_LAB_HEALTH="10.200.0.254"

# VMID LAN SERVER
declare -r VLAN_LAN="10"
declare -r MASK_LAN="24"
declare -r NETMASK_LAN="255.255.255.0"
declare -r GATEWAY_LAN="10.10.0.1"

declare -r VMID_LAN_ASTERISK="321"
declare -r IP_LAN_ASTERISK="10.10.0.21"
declare -r VMID_LAN_LDAP="322"
declare -r IP_LAN_LDAP="10.10.0.22"
declare -r VMID_LAN_ELK="323"
declare -r IP_LAN_ELK="10.10.0.23"
declare -r VMID_LAN_SPLUNK="324"
declare -r IP_LAN_SPLUNK="10.10.0.24"
declare -r VMID_LAN_WINSERVER="325"
declare -r IP_LAN_WINSERVER="10.10.0.25"
declare -r VMID_LAN_OAUTH="326"
declare -r IP_LAN_OAUTH="10.10.0.26"
declare -r VMID_LAN_OPENID="327"
declare -r IP_LAN_OPENID="10.10.0.27"
declare -r VMID_LAN_SQLSERVER="328"
declare -r IP_LAN_SQLSERVER="10.10.0.28"

# VMID LAN PCS
declare -r VLAN_PC="1"
declare -r MASK_PC="24"
declare -r NETMASK_PC="255.255.255.0"
declare -r GATEWAY_PC="10.10.11.1"

declare -r VMID_PC_WIN10="421"
declare -r IP_PC_WIN10="10.10.11.82"
declare -r VMID_PC_WIN7="422"
declare -r IP_PC_WIN7="10.10.11.83"
declare -r VMID_PC_WINXP="423"
declare -r IP_PC_WINXP="10.10.11.84"
declare -r VMID_PC_DEBIAN="424"
declare -r IP_PC_DEBIAN="10.10.11.85"
declare -r VMID_PC_MACOS="425"
declare -r IP_PC_MACOS="10.10.11.86"

# VMID DMZ SERVERS
declare -r VLAN_DMZ="20"
declare -r MASK_DMZ="24"
declare -r NETMASK_DMZ="255.255.255.0"
declare -r GATEWAY_DMZ="10.20.0.1"

declare -r VMID_DMZ_MONGO="521"
declare -r IP_DMZ_MONGO="10.20.0.21"
declare -r VMID_DMZ_MARIADB="522"
declare -r IP_DMZ_MARIADB="10.20.0.22"
declare -r VMID_DMZ_VSFTPD="523"
declare -r IP_DMZ_VSFTPD="10.20.0.23"
declare -r VMID_DMZ_DOJO="524"
declare -r IP_DMZ_DOJO="10.20.0.24"
declare -r VMID_DMZ_APACHE="525" # VARIOS CMS MENOS CONOCIDOS Moodle vBulletin CmsBundle Silverstripe
declare -r IP_DMZ_APACHE="10.20.0.25"
declare -r VMID_DMZ_NAGIOS="526"
declare -r IP_DMZ_NAGIOS="10.20.0.26"
declare -r VMID_DMZ_MUNA="527"
declare -r IP_DMZ_MUNA="10.20.0.27"
declare -r VMID_DMZ_OWNCLOUD="528"
declare -r IP_DMZ_OWNCLOUD="10.20.0.28"
declare -r VMID_DMZ_JOOMLA="529"
declare -r IP_DMZ_JOOMLA="10.20.0.29"
declare -r VMID_DMZ_PRESTASHOP="530"
declare -r IP_DMZ_PRESTASHOP="10.20.0.30"
declare -r VMID_DMZ_DRUPAL="531"
declare -r IP_DMZ_DRUPAL="10.20.0.31"
declare -r VMID_DMZ_WORDPRESS="532"
declare -r IP_DMZ_WORDPRESS="10.20.0.32"
declare -r VMID_DMZ_RADIUS="533"
declare -r IP_DMZ_RADIUS="10.20.0.33"
declare -r VMID_DMZ_DNS="534"
declare -r IP_DMZ_DNS="10.20.0.34"
declare -r VMID_DMZ_HONEYPOT="535"
declare -r IP_DMZ_HONEYPOT="10.20.0.35"
declare -r VMID_DMZ_MAIL="536"
declare -r IP_DMZ_MAIL="10.20.0.36"

# VMID SURICATA
declare -r VLAN_IDS="30"
declare -r MASK_IDS="29"
declare -r NETMASK_IDS="255.255.255.248"
declare -r GATEWAY_IDS="10.30.0.1"

declare -r VMID_IDS_SURICATA="621"
declare -r IP_IDS_SURICATA="10.30.0.2"

# VMID LABORARTIY
declare -r VLAN_LAB="1"
declare -r MASK_LAB="24"
declare -r NETMASK_LAB="255.255.255.0"
declare -r GATEWAY_LAB="172.0.0.1"

#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################

function debug() {
    echo -e "${ORANGE_COLOUR}$1${RESET_COLOUR}"
}

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
