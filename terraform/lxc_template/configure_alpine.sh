#!/bin/bash


# vmid = 4001 esta definido en lxc_template.tf

# Copiamos script en contenedor
pct push 4001 /root/alpine.sh /root/alpine.sh

# Ejecutamos script en el contenedor para su configuracion
echo 'sh /root/alpine.sh' | pct enter 4001

# Paramos contenedor
pct shutdown 4001

# Creamos backup del contenedor para usarlo como template
vzdump 4001 --compress gzip --dumpdir /var/lib/vz/template/ --maxfiles 1
