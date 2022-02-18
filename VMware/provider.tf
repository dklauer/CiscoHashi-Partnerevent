terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.0.2"
    }
  }
}

provider "vsphere" {
  # Configuration options
  user           = var.vsphere_provider.user
  password       = var.vsphere_provider.password
  vsphere_server = var.vsphere_provider.server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
