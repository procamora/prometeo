terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.6.8"
    }
  }
}

provider "proxmox" {
  # pm_parallel     = 1
  pm_tls_insecure = true
  pm_api_url      = var.pm_api_url
  pm_user         = var.username
  pm_password     = var.password
  # pm_otp          = ""
  pm_parallel = 20
}
