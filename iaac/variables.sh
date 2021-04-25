#!/bin/bash

# shellcheck disable=SC2034  # Unused variables, file load for scripts

# Exit script if you try to use an uninitialized variable.
set -o nounset

# Exit script if a statement returns a non-true return value.
#set -o errexit

# Use the error status of the first failure, rather than that of the last item in a pipeline.
set -o pipefail

declare -r DOMAIN="prometeo.sh"

declare -r MY_PATH="/root/prometeo"

KEY="$(pwd)/../certificates/openssh/id_rsa"
declare -r KEY
declare -r SSH="ssh -i $KEY"
declare -r SCP="scp -i $KEY"
declare -r DUMP_PATH="/var/lib/vz/template"

declare -r TIME_SLEEP=10 # pause afer run machine in seconds

declare -r TERRAFORM_STATE_IDS="tf/.myterraform_ids.tfstate"
declare -r TERRAFORM_STATE_LAN="tf/.myterraform_lan.tfstate"
declare -r TERRAFORM_STATE_DMZ="tf/.myterraform_dmz.tfstate"
declare -r TERRAFORM_STATE_HEALTH="tf/.myterraform_health.tfstate"
#############################################################################################

declare -r PM_HOST="192.168.1.200"
declare -r PM_API_URL="https://192.168.1.200:8006/api2/json"
declare -r PM_CNAME="c.prometeo.01"
declare -r PM_NODE="xx1"  # TODO: Si se le pone otro nombre hay que cambiarlo para terraform
declare -r PM_POOL="p.prometeo"
declare -r PM_GROUP="g.prometeo"
declare -r PM_STORAGE="local-lvm"
declare -r PVE_USERNAME="prometeo@pve" # admin
declare -r PM_PASSWORD="prometeo"
declare -r PCT_PASSWORD="prometeo"

declare -r PCT_ALPINE="alpine"
declare -r PCT_DEBIAN="debian"
declare -r PCT_CENTOS="centos"

declare -r PM_BRIDGE="vmbr0"
declare -r PM_BRIDGE_PROMETEO="vmbr1"
declare -r PM_BRIDGE_ISOLATION="vmbr2"
declare -r PCT_ETHERNET="eth0"
declare -r PCT_IP_UNICAST="172.16.0.100/32"
declare -r PCT_NETWORK="10.0.0.0"


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
declare -r VMID_MK="111"
declare -r MAC_WAN_MK="4C:5E:0C:BB:8A:01"

#######################
# VMID HEALTH SERVERS #
#######################
declare -r VMID_DMZ_HEALTH="221"
declare -r IP_DMZ_HEALTH="10.20.0.254"
declare -r VMID_LAN_HEALTH="222"
declare -r IP_LAN_HEALTH="10.10.0.254"
declare -r VMID_PC_HEALTH="223"
declare -r IP_PC_HEALTH="10.10.11.254"
declare -r VMID_IDS_HEALTH="224"
declare -r IP_IDS_HEALTH="10.30.0.3"
declare -r VMID_LAB_HEALTH="225"
declare -r IP_LAB_HEALTH="172.0.0.254"

###################
# VMID LAN SERVER #
###################
declare -r VLAN_LAN="10"
declare -r MASK_LAN="24"
declare -r NETMASK_LAN="255.255.255.0"
declare -r GATEWAY_LAN="10.10.0.1"

declare -r VMID_LAN_ASTERISK="321"
declare -r PORT_LAN_ASTERISK="5060"
declare -r PROTOCOL_LAN_ASTERISK="sip"
declare -r PROXY_LAN_ASTERISK="false"
declare -r IP_LAN_ASTERISK="10.10.0.21"

declare -r VMID_LAN_LDAP="322"
declare -r PORT_LAN_LDAP="389"
declare -r PROTOCOL_LAN_LDAP="ldap"
declare -r PROXY_LAN_LDAP="false"
declare -r IP_LAN_LDAP="10.10.0.22"

declare -r VMID_LAN_ELK="323"
declare -r PORT_LAN_ELK="80"
declare -r PROTOCOL_LAN_ELK="http"
declare -r PROXY_LAN_ELK="323"
declare -r IP_LAN_ELK="10.10.0.23"

declare -r VMID_LAN_SPLUNK="324"
declare -r PORT_LAN_SPLUNK="8000"
declare -r PROTOCOL_LAN_SPLUNK="http"
declare -r PROXY_LAN_SPLUNK="true"
declare -r IP_LAN_SPLUNK="10.10.0.24"

declare -r VMID_LAN_WINSERVER="325"
declare -r PORT_LAN_WINSERVER="80"
declare -r PROTOCOL_LAN_WINSERVER="http"
declare -r PROXY_LAN_WINSERVER="false"
declare -r IP_LAN_WINSERVER="10.10.0.25"

declare -r VMID_LAN_OAUTH="326"
declare -r PORT_LAN_OAUTH="80"
declare -r PROTOCOL_LAN_OAUTH="http"
declare -r PROXY_LAN_OAUTH="false"
declare -r IP_LAN_OAUTH="10.10.0.26"

declare -r VMID_LAN_OPENID="327"
declare -r PORT_LAN_OPENID="80"
declare -r PROTOCOL_LAN_OPENID="http"
declare -r PROXY_LAN_OPENID="false"
declare -r IP_LAN_OPENID="10.10.0.27"

declare -r VMID_LAN_SQLSERVER="328"
declare -r PORT_LAN_SQLSERVER="1433"
declare -r PROTOCOL_LAN_SQLSERVER="http"
declare -r PROXY_LAN_SQLSERVER="false"
declare -r IP_LAN_SQLSERVER="10.10.0.28"

declare -r VMID_LAN_ANSIBLE="329"
declare -r PORT_LAN_ANSIBLE="80"
declare -r PROTOCOL_LAN_ANSIBLE="http"
declare -r PROXY_LAN_ANSIBLE="false"
declare -r IP_LAN_ANSIBLE="10.10.0.29"

################
# VMID LAN PCS #
################
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

####################
# VMID DMZ SERVERS #
####################
declare -r VLAN_DMZ="20"
declare -r MASK_DMZ="24"
declare -r NETMASK_DMZ="255.255.255.0"
declare -r GATEWAY_DMZ="10.20.0.1"

declare -r VMID_DMZ_MONGO="3521"
declare -r PORT_DMZ_MONGO="27017"
declare -r PROTCOL_DMZ_MONGO="http"
declare -r PROXY_DMZ_MONGO="false"
declare -r IP_DMZ_MONGO="10.20.0.21"

declare -r VMID_DMZ_MARIADB="3522"
declare -r PORT_DMZ_MARIADB="3306"
declare -r PROTOCOL_DMZ_MARIADB="http"
declare -r PROXY_DMZ_MARIADB="false"
declare -r IP_DMZ_MARIADB="10.20.0.22"

declare -r VMID_DMZ_VSFTPD="3523"
declare -r PORT_DMZ_VSFTPD="21"
declare -r PROTOCOL_DMZ_VSFTPD="http"
declare -r PROXY_DMZ_VSFTPD="false"
declare -r IP_DMZ_VSFTPD="10.20.0.23"

declare -r VMID_DMZ_DOJO="3524"
declare -r PORT_DMZ_DOJO="80"
declare -r PROTOCOL_DMZ_DOJO="http"
declare -r PROXY_DMZ_DOJO="true"
declare -r IP_DMZ_DOJO="10.20.0.24"

declare -r VMID_DMZ_APACHE="3525" # VARIOS CMS MENOS CONOCIDOS Moodle vBulletin CmsBundle Silverstripe
declare -r PORT_DMZ_APACHE="80"
declare -r PROTOCOL_DMZ_APACHE="http"
declare -r PROXY_DMZ_APACHE="true"
declare -r IP_DMZ_APACHE="10.20.0.25"

declare -r VMID_DMZ_MUNA="3526"
declare -r PORT_DMZ_MUNA="80"
declare -r PROTOCOL_DMZ_MUNA="http"
declare -r PROXY_DMZ_MUNA="true"
declare -r IP_DMZ_MUNA="10.20.0.26"

declare -r VMID_DMZ_OWNCLOUD="3527"
declare -r PORT_DMZ_OWNCLOUD="80"
declare -r PROTOCOL_DMZ_OWNCLOUD="http"
declare -r PROXY_DMZ_OWNCLOUD="true"
declare -r IP_DMZ_OWNCLOUD="10.20.0.27"

declare -r VMID_DMZ_JOOMLA="3528"
declare -r PORT_DMZ_JOOMLA="80"
declare -r PROTOCOL_DMZ_JOOMLA="http"
declare -r PROXY_DMZ_JOOMLA="true"
declare -r IP_DMZ_JOOMLA="10.20.0.28"

declare -r VMID_DMZ_PRESTASHOP="3529"
declare -r PORT_DMZ_PRESTASHOP="80"
declare -r PROTOCOL_DMZ_PRESTASHOP="http"
declare -r PROXY_DMZ_PRESTASHOP="true"
declare -r IP_DMZ_PRESTASHOP="10.20.0.29"

declare -r VMID_DMZ_DRUPAL="3530"
declare -r PORT_DMZ_DRUPAL="80"
declare -r PROTOCOL_DMZ_DRUPAL="http"
declare -r PROXY_DMZ_DRUPAL="true"
declare -r IP_DMZ_DRUPAL="10.20.0.30"

declare -r VMID_DMZ_WORDPRESS="3531"
declare -r PORT_DMZ_WORDPRESS="80"
declare -r PROTOCOL_DMZ_WORDPRESS="http"
declare -r PROXY_DMZ_WORDPRESS="true"
declare -r IP_DMZ_WORDPRESS="10.20.0.31"

declare -r VMID_DMZ_RADIUS="3532"
declare -r PORT_DMZ_RADIUS="1812"
declare -r PROTOCOL_DMZ_RADIUS="http"
declare -r PROXY_DMZ_RADIUS="false"
declare -r IP_DMZ_RADIUS="10.20.0.32"

declare -r VMID_DMZ_DNS="3533"
declare -r PORT_DMZ_DNS="53"
declare -r PROTOCOL_DMZ_DNS="http"
declare -r PROXY_DMZ_DNS="false"
declare -r IP_DMZ_DNS="10.20.0.53" # Ip custom para que quede bonito

declare -r VMID_DMZ_COWRIE="3534"
declare -r PORT_DMZ_COWRIE="22"
declare -r PROTOCOL_DMZ_COWRIE="http"
declare -r PROXY_DMZ_COWRIE="false"
declare -r IP_DMZ_COWRIE="10.20.0.34"

declare -r VMID_DMZ_MAIL="3535"
declare -r PORT_DMZ_MAIL="25"
declare -r PROTOCOL_DMZ_MAIL="http"
declare -r PROXY_DMZ_MAIL="false"
declare -r IP_DMZ_MAIL="10.20.0.35"

declare -r VMID_DMZ_INFLUXDB="3536"
declare -r PORT_DMZ_INFLUXDB="8086"
declare -r PROTOCOL_DMZ_INFLUXDB="http"
declare -r PROXY_DMZ_INFLUXDB="false"
declare -r IP_DMZ_INFLUXDB="10.20.0.36"

declare -r VMID_DMZ_GRAFANA="3537"
declare -r PORT_DMZ_GRAFANA="80"
declare -r PROTOCOL_DMZ_GRAFANA="http"
declare -r PROXY_DMZ_GRAFANA="true"
declare -r IP_DMZ_GRAFANA="10.20.0.37"

declare -r VMID_DMZ_TELEGRAF="3538"
declare -r PORT_DMZ_TELEGRAF="80"
declare -r PROTOCOL_DMZ_TELEGRAF="http"
declare -r PROXY_DMZ_TELEGRAF="false"
declare -r IP_DMZ_TELEGRAF="10.20.0.38"

declare -r VMID_DMZ_NGINX="3539"
declare -r PORT_DMZ_NGINXF="443"
declare -r PROTOCOL_DMZ_NGINX="https"
declare -r PROXY_DMZ_NGINX="false"
declare -r IP_DMZ_NGINXF="10.20.0.39"

#################
# VMID SURICATA #
#################
declare -r VLAN_IDS="30"
declare -r MASK_IDS="29"
declare -r NETMASK_IDS="255.255.255.248"
declare -r GATEWAY_IDS="10.30.0.1"

declare -r VMID_IDS_SURICATA="621"
declare -r PORT_IDS_SURICATA="80"
declare -r PROTOCOL_IDS_SURICATA="http"
declare -r PROXY_IDS_SURICATA="false"
declare -r IP_IDS_SURICATA="10.30.0.2"

###################
# VMID LABORARTIY #
###################
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

function debug_ok() {
    echo -e "${GREEN_COLOUR}$1${RESET_COLOUR}"
}

function debug_err() {
    echo -e "${RED_COLOUR}$1${RESET_COLOUR}"
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
