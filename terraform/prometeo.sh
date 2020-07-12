#!/bin/bash


# set variables
# shellcheck disable=SC1091
source variables.sh


find . -name "*.sh" -exec chmod u+x {} \;
#chmod +x *.sh
#chmod +x lxc_template/*.sh
#chmod +x lxc/*.sh



function basic_config_proxmox() {
    # Instalacion de la confiugracion basica en Proxmox
    ssh root@"$PM_HOST" 'mkdir -p /root/prometeo/'
    scp proxmox_configuration.sh root@"$PM_HOST":/root/prometeo/
    ssh root@"$PM_HOST" 'bash /root/prometeo/proxmox_configuration.sh'
}







function create_templates() {
    # Download template container alpine
    scp templates/proxmox_downloads_templates.sh root@"$PM_HOST":/root/prometeo/
    scp templates/alpine.sh root@$PM_HOST:/root/prometeo/
    scp templates/debian.sh root@$PM_HOST:/root/prometeo/
    ssh root@"$PM_HOST" 'bash /root/prometeo/proxmox_downloads_templates.sh'

    #terraform destroy -auto-approve lxc_template/
    #terraform validate lxc_template/ -with-deps # No es necesario
    #terraform plan --out='templates.tfplan' test/
    #terraform apply -auto-approve 'templates.tfplan'

    # Instalacion y configuracion del contenedor
    #scp templates/configure_alpine.sh root@$PM_HOST:/root/prometeo/
    #ssh root@$PM_HOST 'bash /root/prometeo/configure_alpine.sh'
    #ssh root@$PM_HOST 'bash /root/prometeo/configure_alpine.sh'
}




function create_container_health() {
    # CREACION DE CONTENEDOR CUSTOM PARA HEALTH
    #TEMPLATE_ALPINE_CUSTOM=$(ssh root@$PM_HOST "ls -l /var/lib/vz/template/cache/ | grep -e 'vzdump-lxc-200.*.tar.gz' | awk '{ print $8 }'")
    TEMPLATE_ALPINE=$(ssh root@"$PM_HOST" "ls -l /var/lib/vz/template/cache/ | grep -e 'vzdump-lxc-200.*.tar.gz'")

    TEMPLATE_ALPINE_CUSTOM=$(echo "$TEMPLATE_ALPINE" | xargs | awk '{ print $9 }')

    #sed -i.back -re "s/default = \".*tar\.(xz|gz)\"/default = \"$TEMPLATE_ALPINE_CUSTOM\"/g" lxc/variables.tf

    #ssh root@$PM_HOST 'pct shutdown 4010; pct shutdown 4011; pct shutdown 4012; pct shutdown 4013;' 2> /dev/null

    #cp variables.tf lxc/variables.tf
    #cp provider.tf lxc/provider.tf

    #cd lxc/

    #terraform destroy -auto-approve lxc/
    #terraform validate lxc/ -with-deps # No es necesario
    terraform plan -var "ct_ostemplate=$TEMPLATE_ALPINE_CUSTOM" --out='lxc_pro.tfplan' lxc/
    terraform apply -auto-approve 'lxc_pro.tfplan'


    #cd -

    #rm -f lxc/variables.tf
    #rm -f lxc/provider.tf
}




function clear() {
    #rm *.tfstate
    #rm *.tfplan
    scp delete_vm.sh root@"$PM_HOST":/root/prometeo/
    ssh root@"$PM_HOST" 'bash /root/prometeo/delete_vm.sh'

}


function main() {
    scp variables.sh root@"$PM_HOST":/root/prometeo/

    clear

    #basic_config_proxmox
    #! test -f terraform.tfstate && terraform init
    #test -f asd.tfstate && terraform init -state=asd.tfstate

    create_templates
    #create_container_health

}

main "$@"
