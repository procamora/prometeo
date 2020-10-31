# https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_lxc.go

resource "proxmox_lxc" "health-dmz" {
  features {
    nesting = true
  }
  vmid = var.vmid_dmz_health
  hostname = "dmz.health"
  description = "Container with dmz.health"
  ostype = var.pct_alpine
  start = false

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge_prometeo
    ip = var.pct_ip_unicast
  }

  force = true
  onboot = false
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}

resource "proxmox_lxc" "health-lan" {
  features {
    nesting = true
  }
  vmid = var.vmid_lan_health
  hostname = "lan.health"
  description = "Container with lan.health"
  ostype = var.pct_alpine
  start = false

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge_prometeo
    ip = var.pct_ip_unicast
  }

  force = true
  onboot = false
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}

resource "proxmox_lxc" "health-pc" {
  features {
    nesting = true
  }
  vmid = var.vmid_pc_health
  hostname = "pc.health"
  description = "Container with pc.health"
  ostype = var.pct_alpine
  start = false

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge_prometeo
    ip = "${var.ip_pc_health}/${var.mask_pc}"
    gw = var.gateway_pc
  }

  force = true
  onboot = false
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}

resource "proxmox_lxc" "health-ids" {
  features {
    nesting = true
  }
  vmid = var.vmid_ids_health
  hostname = "ids.health"
  description = "Container with ids.health"
  ostype = var.pct_alpine
  start = false

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge_prometeo
    ip = var.pct_ip_unicast
  }

  force = true
  onboot = false
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}

resource "proxmox_lxc" "health-lab" {
  features {
    nesting = true
  }
  vmid = var.vmid_lab_health
  hostname = "lab.health"
  description = "Container with lab.health"
  ostype = var.pct_alpine
  start = false

  cores = 1
  memory = 128
  swap = 128

  network {
    name = var.pct_ethernet
    bridge = var.pm_bridge_isolation
    ip = "${var.ip_lab_health}/${var.mask_lab}"
    gw = var.gateway_lab
  }

  force = true
  onboot = false
  password = var.pm_password
  pool = var.pm_pool
  storage = var.pm_storage
  ostemplate = "${var.dump_path}/${var.template_health_name}"
  target_node = var.pm_node
  unprivileged = true
}




