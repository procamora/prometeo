# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "mariadb-dmz" {
  vmid = var.vmid_dmz_mariadb
  hostname = "mariadb.dmz"
  description = "Container with mariadb.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "mongo-dmz" {
  vmid = var.vmid_dmz_mongo
  hostname = "mongo.dmz"
  description = "Container with mongo.dmz"
  ostype = var.pct_debian
  start = false

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
  start = false

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


resource "proxmox_lxc" "dojo-dmz" {
  vmid = var.vmid_dmz_dojo
  hostname = "dojo.dmz"
  description = "Container with dojo.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "apache-dmz" {
  vmid = var.vmid_dmz_apache
  hostname = "apache.dmz"
  description = "Container with apache.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "nagios-dmz" {
  vmid = var.vmid_dmz_nagios
  hostname = "nagios.dmz"
  description = "Container with nagios.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "muna-dmz" {
  vmid = var.vmid_dmz_muna
  hostname = "muna.dmz"
  description = "Container with muna.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "owncloud-dmz" {
  vmid = var.vmid_dmz_owncloud
  hostname = "owncloud.dmz"
  description = "Container with owncloud.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "joomla-dmz" {
  vmid = var.vmid_dmz_joomla
  hostname = "joomla.dmz"
  description = "Container with joomla.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "prestashop-dmz" {
  vmid = var.vmid_dmz_prestashop
  hostname = "prestashop.dmz"
  description = "Container with prestashop.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "drupal-dmz" {
  vmid = var.vmid_dmz_drupal
  hostname = "drupal.dmz"
  description = "Container with drupal.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "wordpress-dmz" {
  vmid = var.vmid_dmz_wordpress
  hostname = "wordpress.dmz"
  description = "Container with wordpress.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "radius-dmz" {
  vmid = var.vmid_dmz_radius
  hostname = "radius.dmz"
  description = "Container with radius.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "dns-dmz" {
  vmid = var.vmid_dmz_dns
  hostname = "dns.dmz"
  description = "Container with dns.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "honeypot-dmz" {
  vmid = var.vmid_dmz_honeypot
  hostname = "honeypot.dmz"
  description = "Container with honeypot.dmz"
  ostype = var.pct_debian
  start = false

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


resource "proxmox_lxc" "mail-dmz" {
  vmid = var.vmid_dmz_mail
  hostname = "mail.dmz"
  description = "Container with mail.dmz"
  ostype = var.pct_debian
  start = false

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



