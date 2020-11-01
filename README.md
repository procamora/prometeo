# prometeo

- [ ] REVISAR LAS CLAVES SSH USADAS y la ubicacion de las mismas
- [ ] Meter claves ssh en templates
- [ ] Establecer el tamaño de los disco para los pct



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


```