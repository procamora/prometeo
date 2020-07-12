#!/bin/bash

#############################################################################################
PM_HOST="192.168.1.254"
PM_CNAME="c.prometeo.01"
PM_NODE="proxmox"
PM_POOL="p.prometeo"
PM_GROUP="g.prometeo"
PM_STORAGE="local-lvm"

TEMPLATE_ALPINE="alpine-3.10-default_20190626_amd64.tar.xz"
TEMPLATE_CENTOS="centos-7-default_20190926_amd64.tar.xz"
TEMPLATE_DEBIAN="debian-10.0-standard_10.0-1_amd64.tar.gz"
#############################################################################################

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
 

#############################################################################################
# VMID TEMPLATES
VMID_TEMPLATE_ALPINE="4001"
VMID_TEMPLATE_CENTOS="4002"
VMID_TEMPLATE_DEBIAN="4003"

# VMID HOSTS
VMID_DB="201"
VMID_ANSIBLE="501"