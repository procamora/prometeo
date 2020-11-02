#!/bin/bash

dnf install -y epel-release
dnf upgrade -y && dnf install -y vim ansible git

pip3 install ansible-lint

sed -E -i.back 's/#?host_key_checking = (False|True)/host_key_checking = False/g' /etc/ansible/ansible.cfg

cd /root/ || exit 2


tar xvf ansible.tar

ansible -i inventory.yml lan -m ping -u root

ansible-playbook -i inventory.yml ansible/apache.yml

rm -f ansible.sh ansible.tar # autoclean
