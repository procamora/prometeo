variable "pm_api_url" {
  default = "https://192.168.1.254:8006/api2/json"
}

variable "pm_user" {
  default = "root@pam"
}

variable "pm_password" {
  default = "password"
}

variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDXEcpTAqxQemrkIpEX45ylTLsPhDgko6Qugfv6B1/cioLaeXtI03NgKKMcWv4yMmKMLvJg4adxkEjpn/5IKEA13ljCMZ+Ue29Su+oOYSU8bo3bLlm+h5hvVJeso0irdnrqILNgL4yw38ebmC8IZaKBhiwiGD8sT/LD9VZSqaxnbQ== key used for automation service connections"
}

variable "pm_node" {
  default = "proxmox"
}

variable "pm_pool" {
  default = "p.prometeo"
}

variable "pm_ct_password" {
  default = "password"
}

variable "ct_ostemplate" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default = "alpine-3.10-default_20190626_amd64.tar.xz"
}
