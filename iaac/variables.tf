# DON'T EDIT, auto-generated file


variable "my_path" {
    default = "/root/prometeo"
}

variable "key" {
    default = "/home/procamora/documents/prometeo/certificates/openssh/id_rsa"
}

variable "ssh" {
    default = "ssh -i /home/procamora/documents/prometeo/certificates/openssh/id_rsa"
}

variable "scp" {
    default = "scp -i /home/procamora/documents/prometeo/certificates/openssh/id_rsa"
}

variable "dump_path" {
    default = "/var/lib/vz/template"
}

variable "pm_host" {
    default = "192.168.1.254"
}

variable "pm_api_url" {
    default = "https://192.168.1.254:8006/api2/json"
}

variable "pm_cname" {
    default = "c.prometeo.01"
}

variable "pm_node" {
    default = "proxmox"
}

variable "pm_pool" {
    default = "p.prometeo"
}

variable "pm_group" {
    default = "g.prometeo"
}

variable "pm_storage" {
    default = "local-lvm"
}

variable "pm_bridge" {
    default = "vmbr0"
}

variable "pm_username" {
    default = "root@pam"  # system user is "prometeo"
}

variable "pm_password" {
    default = "password"
}

variable "vmid_template_alpine" {
    default = "4001"
}

variable "template_alpine_name" {
    default = "alpine.tar.gz"
}

variable "vmid_template_centos" {
    default = "4002"
}

variable "template_centos_name" {
    default = "centos.tar.gz"
}

variable "vmid_template_debian" {
    default = "4003"
}

variable "template_debian_name" {
    default = "debian.tar.gz"
}

variable "vmid_template_health" {
    default = "4004"
}

variable "template_health_name" {
    default = "health.tar.gz"
}

variable "vmid_ansible" {
    default = "110"
}

variable "vmid_mk" {
    default = "111"
}

variable "mac_wan_mk" {
    default = "4c:5e:0c:bb:8a:01"
}

variable "vmid_health_dmz" {
    default = "211"
}

variable "vmid_health_lan" {
    default = "212"
}

variable "vmid_health_pc" {
    default = "213"
}

variable "vmid_health_ext" {
    default = "214"
}

variable "vmid_lan_asterisk" {
    default = "311"
}

variable "vmid_lan_ldap" {
    default = "312"
}

variable "vmid_lan_elk" {
    default = "313"
}

variable "vmid_lan_splunk" {
    default = "314"
}

variable "vmid_lan_winserver" {
    default = "315"
}

variable "vmid_lan_oauth" {
    default = "316"
}

variable "vmid_lan_openid" {
    default = "317"
}

variable "vmid_lan_sqlserver" {
    default = "318"
}

variable "vmid_pc_win10" {
    default = "411"
}

variable "vmid_pc_win7" {
    default = "412"
}

variable "vmid_pc_winxp" {
    default = "413"
}

variable "vmid_pc_debian" {
    default = "414"
}

variable "vmid_pc_macos" {
    default = "415"
}

variable "vmid_dmz_mongo" {
    default = "511"
}

variable "vmid_dmz_mariadb" {
    default = "512"
}

variable "vmid_dmz_vsftpd" {
    default = "513"
}

variable "vmid_mir_ids" {
    default = "611"
}
