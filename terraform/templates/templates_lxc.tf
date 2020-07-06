
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



resource "proxmox_lxc" "template-centos" {
  features {
    nesting = true
  }
  vmid = 5001
  hostname = "centos.health"
  description = "Container with health template"
  ostype = "centos"
  #template = true
  start = false

  cores = 2
  memory = 2046
  swap = 2046

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
  ostemplate = "/var/lib/vz/template/cache/centos-7-default_20190926_amd64.tar.xz" # "/var/lib/vz/template/cache/alpine-3.10-default_20190626_amd64.tar.xz"
  #ostemplate = "shared:vztmpl/alpine-3.10-default_20190626_amd64.tar.xz"
  target_node = var.pm_node # Nombre del nodo dentro del Datacenter
  unprivileged = true
}



resource "proxmox_vm_qemu" "vm-12" {
  name        = "var.name"
  target_node = "proxmox"
  clone       = "centos-cloud-image"

  disk {
    id       = 0
    size     = 2
    type     = "virtio"
    iothread = true
    storage  = "local-lvm"
    storage_type = "lvm"
  }

  ssh_user  = "root"
  ipconfig0 = "ip=10.0.0.5/32,gw=10.0.0.1"
  sshkeys   = <<EOF
  ${var.ssh_key}
  EOF
}


resource "proxmox_vm_qemu" "vm-dddd" {
  name        = "var.name2"
  target_node = "proxmox"
  clone       = "centos-cloud-image"

  disk {
    id       = 1
    size     = 2
    type     = "virtio"
    iothread = true
    storage  = "local-lvm"
    storage_type = "lvm"
  }

  ssh_user  = "root"
  ipconfig0 = "ip=10.0.0.5/32,gw=10.0.0.1"
  sshkeys   = <<EOF
  ${var.ssh_key}
  EOF
}
