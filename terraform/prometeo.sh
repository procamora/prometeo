#!/bin/bash


# set variables
source variables.sh

chmod +x *.sh
chmod +x lxc_template/*.sh


scp variables.sh root@$PM_HOST:/root/

# Instalacion de la confiugracion basica en Proxmox
scp proxmox_configuration.sh root@$PM_HOST:/root/
ssh root@$PM_HOST 'bash /root/proxmox_configuration.sh'


# Download template container alpine
scp lxc_template/proxmox_download_template_ct.sh root@$PM_HOST:/root/
ssh root@$PM_HOST 'bash /root/proxmox_download_template_ct.sh'


#sed -i.back -re "s/default = \".*tar\.(xz|gz)\"/default = \"$CONTAINER_ALPINE\"/g" lxc/variables.tf
# Crear contenedor alpine con la config por defecto
#&& terraform validate && terraform plan && terraform apply -auto-approve

terraform init 
cp variables.tf lxc_template/variables.tf
cp provider.tf lxc_template/provider.tf

terraform validate lxc_template/ -with-deps # No es necesario
#terraform plan -var "ct_ostemplate=$CONTAINER_ALPINE" lxc_template/ 
terraform apply -auto-approve lxc_template/

rm -f lxc_template/variables.tf
rm -f lxc_template/provider.tf



# Instalacion y configuracion del contenedor
scp lxc_template/alpine.sh root@$PM_HOST:/root/
scp lxc_template/configure_alpine.sh root@$PM_HOST:/root/
ssh root@$PM_HOST 'bash /root/configure_alpine.sh'







# Para contenedor
#pct stop $(egrep -e  "vmid = ([0-9]+)" lxc/lxc_example.tf | awk '{ print $3 }')




# CREACION DE CONTENEDOR CUSTOM PARA HEALTH
#CONTAINER_ALPINE_CUSTOM=$(ssh root@$PM_HOST "ls -l /var/lib/vz/template/cache/ | grep -e 'vzdump-lxc-200.*.tar.gz' | awk '{ print $8 }'")
CONTAINER_ALPINE_CUSTOM=$(ssh root@$PM_HOST "ls -l /var/lib/vz/template/cache/ | grep -e 'vzdump-lxc-200.*.tar.gz'")

CONTAINER_ALPINE_CUSTOM=$(echo $CONTAINER_ALPINE_CUSTOM | xargs | awk '{ print $9 }')

#sed -i.back -re "s/default = \".*tar\.(xz|gz)\"/default = \"$CONTAINER_ALPINE_CUSTOM\"/g" lxc/variables.tf

###########################3
## creacion contenedores health
#############################

cp variables.tf lxc/variables.tf
cp provider.tf lxc/provider.tf

terraform validate lxc/ -with-deps # No es necesario
#terraform plan -var "ct_ostemplate=$CONTAINER_ALPINE" lxc_template/ 
terraform apply -var "ct_ostemplate=$CONTAINER_ALPINE" -auto-approve lxc/

rm -f lxc/variables.tf
rm -f lxc/provider.tf





































# Remove suscription message
sed -i.back "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
systemctl restart pveproxy.service