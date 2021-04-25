#!/bin/bash

dnf install -y epel-release
dnf upgrade -y && dnf install -y vim ansible git curl wget unzip

pip3 install ansible-lint

sed -E -i.back 's/#?host_key_checking = (False|True)/host_key_checking = False/g' /etc/ansible/ansible.cfg

wget https://releases.hashicorp.com/terraform/0.15.0/terraform_0.15.0_linux_amd64.zip -O /tmp/terraform.zip
unzip -o /tmp/terraform.zip -d /usr/local/bin/ >/dev/null


#cd /root/ || exit 2


#tar xvf ansible.tar
#
#ansible -i inventory.yml lan -m ping -u root
#
#ansible-playbook -i inventory.yml ansible/apache.yml
#
#rm -f ansible.sh ansible.tar # autoclean
