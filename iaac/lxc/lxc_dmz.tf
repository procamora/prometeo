# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "mariadb-dmz" {
  vmid = var.vmid_dmz_mariadb
  hostname = "mariadb.dmz"
  description = "Container with mariadb.dmz"
  ostype = var.pct_centos
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    ip = var.pct_ip_unicast
    tag = var.vlan_dmz
  }

  onboot = false
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_centos_name}"
  target_node = var.pm_node
  unprivileged = true
}


resource "proxmox_lxc" "mongo-dmz" {
  vmid = var.vmid_dmz_mongo
  hostname = "mongo.dmz"
  description = "Container with mongo.dmz"
  ostype = var.pct_debian
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    ip = var.pct_ip_unicast
    tag = var.vlan_dmz
  }

  onboot = false
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_debian_name}"
  target_node = var.pm_node
  unprivileged = false
}


resource "proxmox_lxc" "vsftpd-dmz" {
  vmid = var.vmid_dmz_vsftpd
  hostname = "vsftpd.dmz"
  description = "Container with vsftpd.dmz"
  ostype = var.pct_debian
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge
    ip = var.pct_ip_unicast
    tag = var.vlan_dmz
  }

  onboot = false
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_debian_name}"
  target_node = var.pm_node
  unprivileged = false
}






