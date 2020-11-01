# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "suricata-ids" {
  features {
    nesting = true
  }
  vmid = var.vmid_ids_suricata
  hostname = "suricata.ids"
  description = "Container with suricata.ids"
  ostype = var.pct_centos
  start = false

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge_prometeo
    ip = "${var.ip_ids_suricata}/${var.mask_ids}"
    gw = var.gateway_ids
    tag = var.vlan_ids
  }

  force = true
  onboot = true
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_centos_name}"
  target_node = var.pm_node
  unprivileged = true
}



