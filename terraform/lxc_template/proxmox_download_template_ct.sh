#!/bin/bash

# https://pve.proxmox.com/wiki/Linux_Container

# set variables
source /root/variables.sh

# CONTAINER HEALTH
pveam update
#ALPINE=$(pveam available | grep alpine | awk '{ print $2 }' | head -n 1)
ALPINE=$(pveam available | grep "$CONTAINER_ALPINE" | awk '{ print $2 }')
! test $ALPINE && echo -e "${RED}missing image alpine :( ${NC}" && exit 1
pveam download local $ALPINE
echo -e "${GREEN}Download image alpine${NC}"
 
 
