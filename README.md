
[![CircleCI](https://circleci.com/gh/procamora/prometeo/tree/master.svg?style=shield)](https://circleci.com/gh/procamora/prometeo/tree/master)
![Lint Code Base](https://github.com/procamora/prometeo/workflows/Lint%20Code%20Base/badge.svg)
[![license](https://img.shields.io/github/license/procamora/prometeo.svg?style=flat-square)](https://github.com/procamora/prometeo/blob/master/license.md)
![Maintenance](https://img.shields.io/maintenance/yes/2020.svg?style=flat-square)
[![GitHub last commit](https://img.shields.io/github/last-commit/procamora/prometeo.svg?style=flat-square)](https://github.com/procamora/prometeo/commit/master)


Articulo donde se va a explicar el proceso: https://www.procamora.com/2020/09/escenario_para_pentesting_i_introduccion/


# prometeo (WIP)

- [ ] REVISAR LAS CLAVES SSH USADAS y la ubicacion de las mismas
- [ ] Meter claves ssh en templates
- [ ] Establecer el tamaño de los disco para los pct
- [ ] ansible  poner roles en los playboo




# Install

```bash
sudo unzip terraform_0.12.24_linux_amd64.zip -d /usr/local/bin/

git clone https://github.com/Telmate/terraform-provider-proxmox
cd terraform-provider-proxmox

go install github.com/Telmate/terraform-provider-proxmox/cmd/terraform-provider-proxmox
go install github.com/Telmate/terraform-provider-proxmox/cmd/terraform-provisioner-proxmox

make

mkdir -p ~/.terraform.d/plugins
cp bin/terraform-provider-proxmox ~/.terraform.d/plugins
cp bin/terraform-provisioner-proxmox ~/.terraform.d/plugins
```


https://downloads.cisecurity.org/?bypassToken=Z0LS2zLZwgvSqTK2Ho5L3z3dtvEA7ugR#/



los usuarios tienen que tener datos con cierto valor
vsftp tener varios usuarios y cada uno con ciertos datos



## Exportar imagen de mikrotik previamente configurada

```bash
qemu-img convert -O qcow2 /dev/pve/vm-111-disk-0 /root/prometeo/mikrotik.qcow2
```



## config proxmox

 conectarse a ssh y añadir la clave publica que usaremos para configurar

```bash
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVM8aBvKVc6+3g7pSDiNVb87zMaH4W5rEb9gb3SG41tq85EgXPnrH2A5QB8nOk3HwLb6svuhXYQM7sSvSopR5fIDScFAnG+uftR5KUjOb5+bN5zGLkqmReVpFeI0Ef/Hav1HWM2jhDtb3k/VgC1H6ECl5Z20yGB+1sRkSjMa4tZklB6IqiFeppAa4GtVjJtCW9tdhKuRh9wXFeP9BQ5MhoB6z8rhNUDtfcHh56de8omzFrKm4a1YxnKz4FX7nmog7IjAFLk7SlTiuAxquptUEmWj63yW5P9JiU+2vd+QjRE7lwZdK3n0a5EeAiZNDd7pS9FXZ9TVqQXB0zHxZLGb/5 root@prometeo" >> /root/.ssh/authorized_keys```
```

## INFO

```bash

# Creamos backup del contenedor para usarlo como template
vzdump "$VMID_TEMPLATE_DEBIAN" --compress gzip --dumpdir /var/lib/vz/template/ --maxfiles 1





variable "pm_ct_password" {\n  default = "password"\n}
variable "pm_ct_password" {\n  default = "PRUEBA"\n}




axel -n 10 -o /backup/template/iso/ http://reervidor_64bits_16_latest.iso
pvesh get /nodes/proxmox/lxc
pvesh get /nodes/proxmox/qemu

```


```bash
curl --header "Content-Type: application/json" \
   --request POST \
   --data '{"token":"RG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ"}' \
   http://localhost:8888/health

ip route add 10.10.0.0/24 via 192.168.1.253


ip route add 10.0.0.0/8 via 192.168.1.253
ip route add 172.0.0.0/24 via 192.168.1.253


iptables -A INPUT -i vmbr1 -o vmbr0 -j DROP
```



post-up ip route add 10.0.0.0/8 via 192.168.1.253
post-up ip route add 172.0.0.0/24 via 192.168.1.253



auto vmbr1
iface vmbr1 inet static
        address 10.0.0.0/8
        bridge-ports vmbr0
        bridge-stp off
        bridge-fd 0
#Interface Prometeo

auto vmbr2
iface vmbr2 inet static
        address 172.0.0.0/24
        bridge-ports vmbr1
        bridge-stp off
        bridge-fd 0
#Interface Isolation Labs






# ansible


```bash
# copiar fichero
ansible host* -m copy -a "src=archivo dest=/tmp"

# cambiar permisos
ansible host* -m file -a "path=/etc/conf/archivo.conf mode=644"
ansible host* -m file -a "path=/etc/conf/archivo.conf owner=atareao group=atareao"

# crear directorio
ansible host* -m file -a "path=/ruta/a/directorio state=directory mode=755 owner=atareao"

ansible -i inventory.yml dmz --become -m apt -a "update_cache=yes force_apt_get=yes cache_valid_time=3600"



```
