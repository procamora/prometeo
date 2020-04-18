
# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "health-dmz" {
  features {
    nesting = true
  }
  vmid = 4010
  hostname = "dmz.health"
  description = "Container with dmz.health"
  ostype = "alpine"
  #template = true
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = "eth0"
    bridge = "vmbr0"
    #ip = "dhcp"
    #ip6 = "dhcp"
    ip = "10.20.0.200/24"
    gw = "10.20.0.1"
  }

  onboot = true
  password = var.pm_ct_password
  pool = var.pm_pool
  storage = "local-lvm"
  #ostemplate = "200"
  ostemplate = "/var/lib/vz/template/cache/${var.ct_ostemplate}" # "/var/lib/vz/template/cache/alpine-3.10-default_20190626_amd64.tar.xz"
  #ostemplate = "shared:vztmpl/alpine-3.10-default_20190626_amd64.tar.xz"
  target_node = var.pm_node # Nombre del nodo dentro del Datacenter
  unprivileged = true
}



resource "proxmox_lxc" "health-lan" {
  features {
    nesting = true
  }
  vmid = 4011
  hostname = "lan.health"
  description = "Container with lan.health"
  ostype = "alpine"
  #template = true
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = "eth0"
    bridge = "vmbr0"
    #ip = "dhcp"
    #ip6 = "dhcp"
    ip = "10.10.0.200/24"
    gw = "10.10.0.1"
  }

  onboot = true
  password = var.pm_ct_password
  pool = var.pm_pool
  storage = "local-lvm"
  #ostemplate = "200"
  ostemplate = "/var/lib/vz/template/cache/${var.ct_ostemplate}" # "/var/lib/vz/template/cache/alpine-3.10-default_20190626_amd64.tar.xz"
  #ostemplate = "shared:vztmpl/alpine-3.10-default_20190626_amd64.tar.xz"
  target_node = var.pm_node # Nombre del nodo dentro del Datacenter
  unprivileged = true
}




