# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "health-dmz" {
  #features {
  #  nesting = true
  #}
  vmid = var.vmid_health_dmz
  hostname = "dmz.health"
  description = "Container with dmz.health"
  ostype = var.pct_alpine
  #template = true
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    #ip = "dhcp"
    #ip6 = "dhcp"
    ip = "10.20.0.200/24"
    gw = "10.20.0.1"
    tag = 20
  }

  #onboot = true
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  #ostemplate = var.vmid_template_health
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  # "/var/lib/vz/template/cache/alpine-3.10-default_20190626_amd64.tar.xz"
  #ostemplate = "shared:vztmpl/alpine-3.10-default_20190626_amd64.tar.xz"
  target_node = var.pm_node
  # Nombre del nodo dentro del Datacenter
  unprivileged = true
}

resource "proxmox_lxc" "health-lan" {
  #features {
  #  nesting = true
  #}
  vmid = var.vmid_health_lan
  hostname = "lan.health"
  description = "Container with lan.health"
  ostype = var.pct_alpine
  #start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    #ip = "dhcp"
    #ip6 = "dhcp"
    ip = "10.10.0.200/24"
    gw = "10.10.0.1"
  }

  onboot = true
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}

resource "proxmox_lxc" "health-pc" {
  #features {
  #  nesting = true
  #}
  vmid = var.vmid_health_pc
  hostname = "pc.health"
  description = "Container with pc.health"
  ostype = var.pct_alpine
  #start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    #ip = "dhcp"
    #ip6 = "dhcp"
    ip = "10.10.11.200/24"
    gw = "10.10.0.1"
  }

  onboot = true
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}

resource "proxmox_lxc" "health-testing" {
  #features {
  #  nesting = true
  #}
  vmid = 6666
  hostname = "testing.health"
  description = "Container with testing.health"
  ostype = var.pct_alpine
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    #ip = "dhcp"
    #ip6 = "dhcp"
    ip = "10.20.0.201/24"
    gw = "10.20.0.1"
    tag = 20
  }

  onboot = false
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}




