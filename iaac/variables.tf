# DON'T EDIT, auto-generated file


variable "my_path" {
  type = string
  description = "value set '/root/prometeo' in terraform.tfvars"
  # default = "/root/prometeo"
}

variable "key" {
  type = string
  description = "value set '/home/procamora/documents/prometeo/certificates/openssh/id_rsa' in terraform.tfvars"
  # default = "/home/procamora/documents/prometeo/certificates/openssh/id_rsa"
}

variable "ssh" {
  type = string
  description = "value set 'ssh -i /home/procamora/documents/prometeo/certificates/openssh/id_rsa' in terraform.tfvars"
  # default = "ssh -i /home/procamora/documents/prometeo/certificates/openssh/id_rsa"
}

variable "scp" {
  type = string
  description = "value set 'scp -i /home/procamora/documents/prometeo/certificates/openssh/id_rsa' in terraform.tfvars"
  # default = "scp -i /home/procamora/documents/prometeo/certificates/openssh/id_rsa"
}

variable "dump_path" {
  type = string
  description = "value set '/var/lib/vz/template' in terraform.tfvars"
  # default = "/var/lib/vz/template"
}

variable "terraform_state" {
  type = string
  description = "value set '.myterraform.tfstate' in terraform.tfvars"
  # default = ".myterraform.tfstate"
}

variable "pm_host" {
  type = string
  description = "value set '192.168.1.254' in terraform.tfvars"
  # default = "192.168.1.254"
}

variable "pm_api_url" {
  type = string
  description = "value set 'https://192.168.1.254:8006/api2/json' in terraform.tfvars"
  # default = "https://192.168.1.254:8006/api2/json"
}

variable "pm_cname" {
  type = string
  description = "value set 'c.prometeo.01' in terraform.tfvars"
  # default = "c.prometeo.01"
}

variable "pm_node" {
  type = string
  description = "value set 'proxmox' in terraform.tfvars"
  # default = "proxmox"
}

variable "pm_pool" {
  type = string
  description = "value set 'p.prometeo' in terraform.tfvars"
  # default = "p.prometeo"
}

variable "pm_group" {
  type = string
  description = "value set 'g.prometeo' in terraform.tfvars"
  # default = "g.prometeo"
}

variable "pm_storage" {
  type = string
  description = "value set 'local-lvm' in terraform.tfvars"
  # default = "local-lvm"
}

variable "pm_bridge" {
  type = string
  description = "value set 'vmbr0' in terraform.tfvars"
  # default = "vmbr0"
}

variable "pm_username" {
  type = string
  description = "value set 'root@pam"  # system user is "root' in terraform.tfvars"
  # default = "root@pam"  # system user is "root"
}

variable "pm_password" {
  type = string
  description = "value set 'password' in terraform.tfvars"
  # default = "password"
}

variable "pct_alpine" {
  type = string
  description = "value set 'alpine' in terraform.tfvars"
  # default = "alpine"
}

variable "pct_debian" {
  type = string
  description = "value set 'debian' in terraform.tfvars"
  # default = "debian"
}

variable "pct_centos" {
  type = string
  description = "value set 'centos' in terraform.tfvars"
  # default = "centos"
}

variable "pct_ethernet" {
  type = string
  description = "value set 'eth0' in terraform.tfvars"
  # default = "eth0"
}

variable "vmid_template_alpine" {
  type = string
  description = "value set '4001' in terraform.tfvars"
  # default = "4001"
}

variable "template_alpine_name" {
  type = string
  description = "value set 'alpine.tar.gz' in terraform.tfvars"
  # default = "alpine.tar.gz"
}

variable "vmid_template_centos" {
  type = string
  description = "value set '4002' in terraform.tfvars"
  # default = "4002"
}

variable "template_centos_name" {
  type = string
  description = "value set 'centos.tar.gz' in terraform.tfvars"
  # default = "centos.tar.gz"
}

variable "vmid_template_debian" {
  type = string
  description = "value set '4003' in terraform.tfvars"
  # default = "4003"
}

variable "template_debian_name" {
  type = string
  description = "value set 'debian.tar.gz' in terraform.tfvars"
  # default = "debian.tar.gz"
}

variable "template_debian_original_name" {
  type = string
  description = "value set 'debian_original.tar.gz' in terraform.tfvars"
  # default = "debian_original.tar.gz"
}

variable "vmid_template_health" {
  type = string
  description = "value set '4004' in terraform.tfvars"
  # default = "4004"
}

variable "template_health_name" {
  type = string
  description = "value set 'health.tar.gz' in terraform.tfvars"
  # default = "health.tar.gz"
}

variable "vmid_ansible" {
  type = string
  description = "value set '110' in terraform.tfvars"
  # default = "110"
}

variable "vmid_mk" {
  type = string
  description = "value set '111' in terraform.tfvars"
  # default = "111"
}

variable "mac_wan_mk" {
  type = string
  description = "value set '4c:5e:0c:bb:8a:01' in terraform.tfvars"
  # default = "4c:5e:0c:bb:8a:01"
}

variable "vmid_health_dmz" {
  type = string
  description = "value set '211' in terraform.tfvars"
  # default = "211"
}

variable "vmid_health_lan" {
  type = string
  description = "value set '212' in terraform.tfvars"
  # default = "212"
}

variable "vmid_health_pc" {
  type = string
  description = "value set '213' in terraform.tfvars"
  # default = "213"
}

variable "vmid_health_ext" {
  type = string
  description = "value set '214' in terraform.tfvars"
  # default = "214"
}

variable "vlan_lan" {
  type = string
  description = "value set '10' in terraform.tfvars"
  # default = "10"
}

variable "mask_lan" {
  type = string
  description = "value set '24' in terraform.tfvars"
  # default = "24"
}

variable "netmask_lan" {
  type = string
  description = "value set '255.255.255.0' in terraform.tfvars"
  # default = "255.255.255.0"
}

variable "vmid_lan_asterisk" {
  type = string
  description = "value set '311' in terraform.tfvars"
  # default = "311"
}

variable "vmid_lan_ldap" {
  type = string
  description = "value set '312' in terraform.tfvars"
  # default = "312"
}

variable "vmid_lan_elk" {
  type = string
  description = "value set '313' in terraform.tfvars"
  # default = "313"
}

variable "vmid_lan_splunk" {
  type = string
  description = "value set '314' in terraform.tfvars"
  # default = "314"
}

variable "vmid_lan_winserver" {
  type = string
  description = "value set '315' in terraform.tfvars"
  # default = "315"
}

variable "vmid_lan_oauth" {
  type = string
  description = "value set '316' in terraform.tfvars"
  # default = "316"
}

variable "vmid_lan_openid" {
  type = string
  description = "value set '317' in terraform.tfvars"
  # default = "317"
}

variable "vmid_lan_sqlserver" {
  type = string
  description = "value set '318' in terraform.tfvars"
  # default = "318"
}

variable "mask_pc" {
  type = string
  description = "value set '24' in terraform.tfvars"
  # default = "24"
}

variable "netmask_pc" {
  type = string
  description = "value set '255.255.255.0' in terraform.tfvars"
  # default = "255.255.255.0"
}

variable "vmid_pc_win10" {
  type = string
  description = "value set '411' in terraform.tfvars"
  # default = "411"
}

variable "vmid_pc_win7" {
  type = string
  description = "value set '412' in terraform.tfvars"
  # default = "412"
}

variable "vmid_pc_winxp" {
  type = string
  description = "value set '413' in terraform.tfvars"
  # default = "413"
}

variable "vmid_pc_debian" {
  type = string
  description = "value set '414' in terraform.tfvars"
  # default = "414"
}

variable "vmid_pc_macos" {
  type = string
  description = "value set '415' in terraform.tfvars"
  # default = "415"
}

variable "vlan_dmz" {
  type = string
  description = "value set '20' in terraform.tfvars"
  # default = "20"
}

variable "mask_dmz" {
  type = string
  description = "value set '24' in terraform.tfvars"
  # default = "24"
}

variable "netmask_dmz" {
  type = string
  description = "value set '255.255.255.0' in terraform.tfvars"
  # default = "255.255.255.0"
}

variable "vmid_dmz_mongo" {
  type = string
  description = "value set '511' in terraform.tfvars"
  # default = "511"
}

variable "ip_dmz_mongo" {
  type = string
  description = "value set '10.20.0.20' in terraform.tfvars"
  # default = "10.20.0.20"
}

variable "vmid_dmz_mariadb" {
  type = string
  description = "value set '512' in terraform.tfvars"
  # default = "512"
}

variable "ip_dmz_mariadb" {
  type = string
  description = "value set '10.20.0.21' in terraform.tfvars"
  # default = "10.20.0.21"
}

variable "vmid_dmz_vsftpd" {
  type = string
  description = "value set '513' in terraform.tfvars"
  # default = "513"
}

variable "ip_dmz_vsftpd" {
  type = string
  description = "value set '10.20.0.22' in terraform.tfvars"
  # default = "10.20.0.22"
}

variable "vmid_mir_ids" {
  type = string
  description = "value set '611' in terraform.tfvars"
  # default = "611"
}
