
# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "template-alpine" {
  features {
    nesting = true
  }
  vmid = 4001
  hostname = "template.health"
  description = "Container with health template"
  ostype = "alpine"
  #template = true
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    ip6 = "dhcp"
    #ip = "10.10.10.19/24"
    #gw = "10.10.10.1"
  }

  onboot = false
  password = var.pm_ct_password
  pool = var.pm_pool
  storage = "local-lvm"
  #ostemplate = "200"
  ostemplate = "/var/lib/vz/template/cache/${var.ct_ostemplate}" # "/var/lib/vz/template/cache/alpine-3.10-default_20190626_amd64.tar.xz"
  #ostemplate = "shared:vztmpl/alpine-3.10-default_20190626_amd64.tar.xz"
  target_node = var.pm_node # Nombre del nodo dentro del Datacenter
  unprivileged = true
}
