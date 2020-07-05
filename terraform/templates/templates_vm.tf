
# https://cloud.centos.org/centos/7/images/
# https://cloud.debian.org/images/cloud/

resource "proxmox_vm_qemu" "template-centos" {
  count             = 1
  name = "centos.template-${count.index}"
  desc = "vm quemu with centos template"
  #id = 5001

  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = var.pm_node # Nombre del nodo dentro del Datacenter

  # The destination resource pool for the new VM
  pool = var.pm_pool

  # The template name to clone this vm from
  #iso = "VBoxGuestAdditions_6.0.14.iso"
  clone = "centos-cloud-image"

  # Activate QEMU agent for this VM
  agent = 1

  os_type = "Linux"
  cores = "2"
  sockets = "2"
  vcpus = "0"
  cpu = "host"
  memory = "4096"
  scsihw = "lsi"   # virtio-scsi-pci
  #bootdisk = "scsi0"

  # Setup the disk. The id has to be unique
  disk {
    id = 0
    type = "virtio"    #"scsi"
    storage = "local-lvm"  # ceph-storage-pool
    #storage_type = "lvm"  # rbd
    size = 32
    format = "raw"
    iothread = true
  }

  # Setup the network interface and assign a vlan tag: 1
  network {
    id = 0
    model = "virtio"
    #macaddr = ""
    bridge = "vmbr0"
    tag = 1
  }

  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  ipconfig0 = "ip=192.168.10.20/24,gw=192.168.10.1"

  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}