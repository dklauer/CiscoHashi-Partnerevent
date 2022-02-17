terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "1.2.0"
    }
  }
}


provider "aci" {
  # cisco-aci user name
  username = var.aci_provider.username
  # cisco-aci password
  password = var.aci_provider.password
  # cisco-aci url
  url      = var.aci_provider.url
  insecure = true
}