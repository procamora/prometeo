# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "asterisk-lan" {
  vmid = var.vmid_lan_asterisk
  hostname = "asterisk.lan"
  description = "Container with asterisk.lan"
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


resource "proxmox_lxc" "ldap-lan" {
  vmid = var.vmid_lan_ldap
  hostname = "ldap.lan"
  description = "Container with ldap.lan"
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


resource "proxmox_lxc" "elk-lan" {
  vmid = var.vmid_lan_elk
  hostname = "elk.lan"
  description = "Container with elk.lan"
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



resource "proxmox_lxc" "splunk-lan" {
  vmid = var.vmid_lan_splunk
  hostname = "splunk.lan"
  description = "Container with splunk.lan"
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


resource "proxmox_lxc" "oauth-lan" {
  vmid = var.vmid_lan_oauth
  hostname = "oauth.lan"
  description = "Container with oauth.lan"
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


resource "proxmox_lxc" "openid-lan" {
  vmid = var.vmid_lan_openid
  hostname = "openid.lan"
  description = "Container with openid.lan"
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


