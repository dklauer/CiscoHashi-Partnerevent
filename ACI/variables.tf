variable "aci_provider" {
  type = object({
    username = string
    password = string
    url      = string
  })
}

variable "tenant" {
  type = object({
    name = string
  })
}

variable "application_profile" {
  type = object({
    name = string
  })
}

variable "epg" {
  type = object({
    name              = string
    epg_to_domain_tdn = string
  })
}

variable "vrf" {
  type = object({
    name = string
  })
}

variable "bd" {
  type = object({
    name                     = string
    relation_fv_rs_bd_to_out = string
    subnet_ip                = string
  })
}