# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "mariadb-dmz" {
  #features {
  #  nesting = true
  #}
  vmid = var.vmid_dmz_mariadb
  hostname = "mariadb.dmz"
  description = "Container with mariadb.dmz"
  ostype = var.pct_centos
  #template = true
  #start = true

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
  password = var.pct_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_centos_name}"
  target_node = var.pm_node
  unprivileged = true
}
