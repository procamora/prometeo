#!/bin/bash

source /root/prometeo/variables.sh


# vmid = $VMID_TEMPLATE_DEBIAN esta definido en lxc_template.tf

# Copiamos script en contenedor
pct push $VMID_TEMPLATE_DEBIAN /root/prometeo/alpine.sh /root/alpine.sh

# Ejecutamos script en el contenedor para su configuracion
echo 'sh /root/alpine.sh' | pct enter $VMID_TEMPLATE_DEBIAN

# Paramos contenedor
pct shutdown $VMID_TEMPLATE_DEBIAN

# Creamos backup del contenedor para usarlo como template
vzdump $VMID_TEMPLATE_DEBIAN --compress gzip --dumpdir /var/lib/vz/template/ --maxfiles 1
