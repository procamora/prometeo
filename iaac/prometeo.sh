#!/bin/bash

# set variables
source variables.sh

find . -name "*.sh" -exec chmod u+x {} \;
#chmod +x *.sh
#chmod +x lxc_template/*.sh
#chmod +x lxc/*.sh



function basic_config_proxmox() {
    # Instalacion de la confiugracion basica en Proxmox
    $SSH root@"$PM_HOST" "mkdir -p $MY_PATH/"
    $SCP proxmox_configuration.sh root@"$PM_HOST":"$MY_PATH"/
    $SCP variables.sh root@"$PM_HOST":"$MY_PATH"/
    $SCP "$KEY" root@"$PM_HOST":"$MY_PATH"/
    $SCP "$KEY.pub" root@"$PM_HOST":"$MY_PATH"/
    $SSH root@"$PM_HOST" "cd $MY_PATH && bash proxmox_configuration.sh"
}







function create_templates() {
    # Download template container alpine
    $SCP templates/proxmox_downloads_templates.sh root@"$PM_HOST":"$MY_PATH"/
    $SCP templates/alpine.sh root@"$PM_HOST":"$MY_PATH"/
    $SCP templates/ansible.sh root@"$PM_HOST":"$MY_PATH"/
    $SCP templates/centos.sh root@"$PM_HOST":"$MY_PATH"/
    $SCP templates/debian.sh root@"$PM_HOST":"$MY_PATH"/
    $SCP templates/health.sh root@"$PM_HOST":"$MY_PATH"/
    #$SCP mikrotik.qcow2 root@"$PM_HOST":"$MY_PATH"/  # FIXME remove comment
    $SSH root@"$PM_HOST" "cd $MY_PATH && bash proxmox_downloads_templates.sh"

    #terraform destroy -auto-approve lxc_template/
    #terraform validate lxc_template/ -with-deps # No es necesario
    #terraform plan --out='templates.tfplan' test/
    #terraform apply -auto-approve 'templates.tfplan'

    # Instalacion y configuracion del contenedor
    #$SCP templates/configure_alpine.sh root@$PM_HOST:$MY_PATH/
    #$SSH root@$PM_HOST 'bash $MY_PATH/configure_alpine.sh'
    #$SSH root@$PM_HOST 'bash $MY_PATH/configure_alpine.sh'
}




function create_container_health() {
    # CREACION DE CONTENEDOR CUSTOM PARA HEALTH
    #TEMPLATE_ALPINE_CUSTOM=$($SSH root@$PM_HOST "ls -l /var/lib/vz/template/cache/ | grep -e 'vzdump-lxc-200.*.tar.gz' | awk '{ print $8 }'")
    TEMPLATE_ALPINE=$($SSH root@"$PM_HOST" "ls -l /var/lib/vz/template/cache/ | grep -e 'vzdump-lxc-200.*.tar.gz'")

    TEMPLATE_ALPINE_CUSTOM=$(echo "$TEMPLATE_ALPINE" | xargs | awk '{ print $9 }')

    #sed -i.back -re "s/default = \".*tar\.(xz|gz)\"/default = \"$TEMPLATE_ALPINE_CUSTOM\"/g" lxc/variables.tf

    #$SSH root@$PM_HOST 'pct shutdown 4010; pct shutdown 4011; pct shutdown 4012; pct shutdown 4013;' 2> /dev/null

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
    $SCP delete_vm.sh root@"$PM_HOST":"$MY_PATH"/
    $SSH root@"$PM_HOST" "bash $MY_PATH/delete_vm.sh"
}


function main() {
    basic_config_proxmox

    $SCP variables.sh root@"$PM_HOST":"$MY_PATH"/

    clear

    #! test -f terraform.tfstate && terraform init
    #test -f asd.tfstate && terraform init -state=asd.tfstate

    create_templates
    #create_container_health

}

main "$@"
