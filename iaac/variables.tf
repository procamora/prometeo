# DON'T EDIT, auto-generated file


variable "my_path" {
  type = string
  description = "value set '/root/prometeo' in terraform.tfvars"
  # default = "/root/prometeo"
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

variable "terraform_state_ids" {
  type = string
  description = "value set '.myterraform_ids.tfstate' in terraform.tfvars"
  # default = ".myterraform_ids.tfstate"
}

variable "terraform_state_lan" {
  type = string
  description = "value set '.myterraform_lan.tfstate' in terraform.tfvars"
  # default = ".myterraform_lan.tfstate"
}

variable "terraform_state_dmz" {
  type = string
  description = "value set '.myterraform_dmz.tfstate' in terraform.tfvars"
  # default = ".myterraform_dmz.tfstate"
}

variable "terraform_state_health" {
  type = string
  description = "value set '.myterraform_health.tfstate' in terraform.tfvars"
  # default = ".myterraform_health.tfstate"
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

variable "pm_username" {
  type = string
  description = "value set 'root@pam" # system user is "root' in terraform.tfvars"
  # default = "root@pam" # system user is "root"
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

variable "pm_bridge" {
  type = string
  description = "value set 'vmbr0' in terraform.tfvars"
  # default = "vmbr0"
}

variable "pm_bridge_prometeo" {
  type = string
  description = "value set 'vmbr1' in terraform.tfvars"
  # default = "vmbr1"
}

variable "pm_bridge_isolation" {
  type = string
  description = "value set 'vmbr2' in terraform.tfvars"
  # default = "vmbr2"
}

variable "pct_ethernet" {
  type = string
  description = "value set 'eth0' in terraform.tfvars"
  # default = "eth0"
}

variable "pct_ip_unicast" {
  type = string
  description = "value set '172.16.0.100/32' in terraform.tfvars"
  # default = "172.16.0.100/32"
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

variable "vmid_dmz_health" {
  type = string
  description = "value set '221' in terraform.tfvars"
  # default = "221"
}

variable "ip_dmz_health" {
  type = string
  description = "value set '10.20.0.254' in terraform.tfvars"
  # default = "10.20.0.254"
}

variable "vmid_lan_health" {
  type = string
  description = "value set '222' in terraform.tfvars"
  # default = "222"
}

variable "ip_lan_health" {
  type = string
  description = "value set '10.10.0.254' in terraform.tfvars"
  # default = "10.10.0.254"
}

variable "vmid_pc_health" {
  type = string
  description = "value set '223' in terraform.tfvars"
  # default = "223"
}

variable "ip_pc_health" {
  type = string
  description = "value set '10.10.11.254' in terraform.tfvars"
  # default = "10.10.11.254"
}

variable "vmid_ids_health" {
  type = string
  description = "value set '224' in terraform.tfvars"
  # default = "224"
}

variable "ip_ids_health" {
  type = string
  description = "value set '10.30.0.3' in terraform.tfvars"
  # default = "10.30.0.3"
}

variable "vmid_lab_health" {
  type = string
  description = "value set '225' in terraform.tfvars"
  # default = "225"
}

variable "ip_lab_health" {
  type = string
  description = "value set '172.0.0.254' in terraform.tfvars"
  # default = "172.0.0.254"
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

variable "gateway_lan" {
  type = string
  description = "value set '10.10.0.1' in terraform.tfvars"
  # default = "10.10.0.1"
}

variable "vmid_lan_asterisk" {
  type = string
  description = "value set '321' in terraform.tfvars"
  # default = "321"
}

variable "ip_lan_asterisk" {
  type = string
  description = "value set '10.10.0.21' in terraform.tfvars"
  # default = "10.10.0.21"
}

variable "vmid_lan_ldap" {
  type = string
  description = "value set '322' in terraform.tfvars"
  # default = "322"
}

variable "ip_lan_ldap" {
  type = string
  description = "value set '10.10.0.22' in terraform.tfvars"
  # default = "10.10.0.22"
}

variable "vmid_lan_elk" {
  type = string
  description = "value set '323' in terraform.tfvars"
  # default = "323"
}

variable "ip_lan_elk" {
  type = string
  description = "value set '10.10.0.23' in terraform.tfvars"
  # default = "10.10.0.23"
}

variable "vmid_lan_splunk" {
  type = string
  description = "value set '324' in terraform.tfvars"
  # default = "324"
}

variable "ip_lan_splunk" {
  type = string
  description = "value set '10.10.0.24' in terraform.tfvars"
  # default = "10.10.0.24"
}

variable "vmid_lan_winserver" {
  type = string
  description = "value set '325' in terraform.tfvars"
  # default = "325"
}

variable "ip_lan_winserver" {
  type = string
  description = "value set '10.10.0.25' in terraform.tfvars"
  # default = "10.10.0.25"
}

variable "vmid_lan_oauth" {
  type = string
  description = "value set '326' in terraform.tfvars"
  # default = "326"
}

variable "ip_lan_oauth" {
  type = string
  description = "value set '10.10.0.26' in terraform.tfvars"
  # default = "10.10.0.26"
}

variable "vmid_lan_openid" {
  type = string
  description = "value set '327' in terraform.tfvars"
  # default = "327"
}

variable "ip_lan_openid" {
  type = string
  description = "value set '10.10.0.27' in terraform.tfvars"
  # default = "10.10.0.27"
}

variable "vmid_lan_sqlserver" {
  type = string
  description = "value set '328' in terraform.tfvars"
  # default = "328"
}

variable "ip_lan_sqlserver" {
  type = string
  description = "value set '10.10.0.28' in terraform.tfvars"
  # default = "10.10.0.28"
}

variable "vlan_pc" {
  type = string
  description = "value set '1' in terraform.tfvars"
  # default = "1"
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

variable "gateway_pc" {
  type = string
  description = "value set '10.10.11.1' in terraform.tfvars"
  # default = "10.10.11.1"
}

variable "vmid_pc_win10" {
  type = string
  description = "value set '421' in terraform.tfvars"
  # default = "421"
}

variable "ip_pc_win10" {
  type = string
  description = "value set '10.10.11.82' in terraform.tfvars"
  # default = "10.10.11.82"
}

variable "vmid_pc_win7" {
  type = string
  description = "value set '422' in terraform.tfvars"
  # default = "422"
}

variable "ip_pc_win7" {
  type = string
  description = "value set '10.10.11.83' in terraform.tfvars"
  # default = "10.10.11.83"
}

variable "vmid_pc_winxp" {
  type = string
  description = "value set '423' in terraform.tfvars"
  # default = "423"
}

variable "ip_pc_winxp" {
  type = string
  description = "value set '10.10.11.84' in terraform.tfvars"
  # default = "10.10.11.84"
}

variable "vmid_pc_debian" {
  type = string
  description = "value set '424' in terraform.tfvars"
  # default = "424"
}

variable "ip_pc_debian" {
  type = string
  description = "value set '10.10.11.85' in terraform.tfvars"
  # default = "10.10.11.85"
}

variable "vmid_pc_macos" {
  type = string
  description = "value set '425' in terraform.tfvars"
  # default = "425"
}

variable "ip_pc_macos" {
  type = string
  description = "value set '10.10.11.86' in terraform.tfvars"
  # default = "10.10.11.86"
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

variable "gateway_dmz" {
  type = string
  description = "value set '10.20.0.1' in terraform.tfvars"
  # default = "10.20.0.1"
}

variable "vmid_dmz_mongo" {
  type = string
  description = "value set '521' in terraform.tfvars"
  # default = "521"
}

variable "ip_dmz_mongo" {
  type = string
  description = "value set '10.20.0.21' in terraform.tfvars"
  # default = "10.20.0.21"
}

variable "vmid_dmz_mariadb" {
  type = string
  description = "value set '522' in terraform.tfvars"
  # default = "522"
}

variable "ip_dmz_mariadb" {
  type = string
  description = "value set '10.20.0.22' in terraform.tfvars"
  # default = "10.20.0.22"
}

variable "vmid_dmz_vsftpd" {
  type = string
  description = "value set '523' in terraform.tfvars"
  # default = "523"
}

variable "ip_dmz_vsftpd" {
  type = string
  description = "value set '10.20.0.23' in terraform.tfvars"
  # default = "10.20.0.23"
}

variable "vmid_dmz_dojo" {
  type = string
  description = "value set '524' in terraform.tfvars"
  # default = "524"
}

variable "ip_dmz_dojo" {
  type = string
  description = "value set '10.20.0.24' in terraform.tfvars"
  # default = "10.20.0.24"
}

variable "vmid_dmz_apache" {
  type = string
  description = "value set '525' in terraform.tfvars"
  # default = "525"
}

variable "ip_dmz_apache" {
  type = string
  description = "value set '10.20.0.25' in terraform.tfvars"
  # default = "10.20.0.25"
}

variable "vmid_dmz_nagios" {
  type = string
  description = "value set '526' in terraform.tfvars"
  # default = "526"
}

variable "ip_dmz_nagios" {
  type = string
  description = "value set '10.20.0.26' in terraform.tfvars"
  # default = "10.20.0.26"
}

variable "vmid_dmz_muna" {
  type = string
  description = "value set '527' in terraform.tfvars"
  # default = "527"
}

variable "ip_dmz_muna" {
  type = string
  description = "value set '10.20.0.27' in terraform.tfvars"
  # default = "10.20.0.27"
}

variable "vmid_dmz_owncloud" {
  type = string
  description = "value set '528' in terraform.tfvars"
  # default = "528"
}

variable "ip_dmz_owncloud" {
  type = string
  description = "value set '10.20.0.28' in terraform.tfvars"
  # default = "10.20.0.28"
}

variable "vmid_dmz_joomla" {
  type = string
  description = "value set '529' in terraform.tfvars"
  # default = "529"
}

variable "ip_dmz_joomla" {
  type = string
  description = "value set '10.20.0.29' in terraform.tfvars"
  # default = "10.20.0.29"
}

variable "vmid_dmz_prestashop" {
  type = string
  description = "value set '530' in terraform.tfvars"
  # default = "530"
}

variable "ip_dmz_prestashop" {
  type = string
  description = "value set '10.20.0.30' in terraform.tfvars"
  # default = "10.20.0.30"
}

variable "vmid_dmz_drupal" {
  type = string
  description = "value set '531' in terraform.tfvars"
  # default = "531"
}

variable "ip_dmz_drupal" {
  type = string
  description = "value set '10.20.0.31' in terraform.tfvars"
  # default = "10.20.0.31"
}

variable "vmid_dmz_wordpress" {
  type = string
  description = "value set '532' in terraform.tfvars"
  # default = "532"
}

variable "ip_dmz_wordpress" {
  type = string
  description = "value set '10.20.0.32' in terraform.tfvars"
  # default = "10.20.0.32"
}

variable "vmid_dmz_radius" {
  type = string
  description = "value set '533' in terraform.tfvars"
  # default = "533"
}

variable "ip_dmz_radius" {
  type = string
  description = "value set '10.20.0.33' in terraform.tfvars"
  # default = "10.20.0.33"
}

variable "vmid_dmz_dns" {
  type = string
  description = "value set '534' in terraform.tfvars"
  # default = "534"
}

variable "ip_dmz_dns" {
  type = string
  description = "value set '10.20.0.34' in terraform.tfvars"
  # default = "10.20.0.34"
}

variable "vmid_dmz_honeypot" {
  type = string
  description = "value set '535' in terraform.tfvars"
  # default = "535"
}

variable "ip_dmz_honeypot" {
  type = string
  description = "value set '10.20.0.35' in terraform.tfvars"
  # default = "10.20.0.35"
}

variable "vmid_dmz_mail" {
  type = string
  description = "value set '536' in terraform.tfvars"
  # default = "536"
}

variable "ip_dmz_mail" {
  type = string
  description = "value set '10.20.0.36' in terraform.tfvars"
  # default = "10.20.0.36"
}

variable "vlan_ids" {
  type = string
  description = "value set '30' in terraform.tfvars"
  # default = "30"
}

variable "mask_ids" {
  type = string
  description = "value set '29' in terraform.tfvars"
  # default = "29"
}

variable "netmask_ids" {
  type = string
  description = "value set '255.255.255.248' in terraform.tfvars"
  # default = "255.255.255.248"
}

variable "gateway_ids" {
  type = string
  description = "value set '10.30.0.1' in terraform.tfvars"
  # default = "10.30.0.1"
}

variable "vmid_ids_suricata" {
  type = string
  description = "value set '621' in terraform.tfvars"
  # default = "621"
}

variable "ip_ids_suricata" {
  type = string
  description = "value set '10.30.0.2' in terraform.tfvars"
  # default = "10.30.0.2"
}

variable "vlan_lab" {
  type = string
  description = "value set '1' in terraform.tfvars"
  # default = "1"
}

variable "mask_lab" {
  type = string
  description = "value set '24' in terraform.tfvars"
  # default = "24"
}

variable "netmask_lab" {
  type = string
  description = "value set '255.255.255.0' in terraform.tfvars"
  # default = "255.255.255.0"
}

variable "gateway_lab" {
  type = string
  description = "value set '172.0.0.1' in terraform.tfvars"
  # default = "172.0.0.1"
}
