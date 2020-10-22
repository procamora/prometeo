# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "suricata-ids" {
  features {
    nesting = true
  }
  vmid = var.vmid_ids_suricata
  hostname = "suricata.ids"
  description = "Container with suricata.ids"
  ostype = "alpine"
  start = true

  cores = 1
  memory = 128
  swap = 128

  network {
    name = "eth0"
    bridge = var.pm_bridge
    #ip = "dhcp"
    #ip6 = "dhcp"
    ip = "10.30.0.2/24"
    gw = "10.30.0.1"
  }

  onboot = true
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}



