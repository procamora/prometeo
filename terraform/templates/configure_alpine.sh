#!/bin/bash

source /root/prometeo/variables.sh


# vmid = $VMID_TEMPLATE_ALPINE esta definido en lxc_template.tf

# Copiamos script en contenedor
pct push $VMID_TEMPLATE_ALPINE /root/prometeo/alpine.sh /root/alpine.sh

# Ejecutamos script en el contenedor para su configuracion
echo 'sh /root/alpine.sh' | pct enter $VMID_TEMPLATE_ALPINE

# Paramos contenedor
pct shutdown $VMID_TEMPLATE_ALPINE

# Creamos backup del contenedor para usarlo como template
vzdump $VMID_TEMPLATE_ALPINE --compress gzip --dumpdir /var/lib/vz/template/ --maxfiles 1
