# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "health-dmz" {
  #features {
  #  nesting = true
  #}
  vmid = var.vmid_dmz_health
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
    ip = var.pct_ip_unicast
    #gw = "10.20.0.1"
    tag = var.vlan_dmz
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
  vmid = var.vmid_lan_health
  hostname = "lan.health"
  description = "Container with lan.health"
  ostype = var.pct_alpine
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    ip = var.pct_ip_unicast
    tag = var.vlan_lan
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
  vmid = var.vmid_pc_health
  hostname = "pc.health"
  description = "Container with pc.health"
  ostype = var.pct_alpine
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    ip = var.pct_ip_unicast
    tag = var.vlan_pc
  }

  onboot = true
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}


resource "proxmox_lxc" "health-ids" {
  vmid = var.vmid_ids_health
  hostname = "ids.health"
  description = "Container with ids.health"
  ostype = var.pct_alpine
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    ip = var.pct_ip_unicast
    tag = var.vlan_pc
  }

  onboot = true
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}


resource "proxmox_lxc" "health-ext" {
  vmid = var.vmid_ext_health
  hostname = "ext.health"
  description = "Container with ext.health"
  ostype = var.pct_alpine
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    ip = var.pct_ip_unicast
    tag = var.vlan_pc
  }

  onboot = true
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}




