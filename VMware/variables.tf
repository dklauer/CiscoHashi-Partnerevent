# Variables for the vCenter provider
# variable "vsphere_user" {
#   type    = string
#   default = "administrator@vsphere.local"
# }

# variable "vsphere_password" {
#   type    = string
# }

# variable "vsphere_server" {
#   type    = string
# }

variable "vsphere_provider" {
  type = object({
    user     = string
    password = string
    server   = string
  })
}

variable "vcenter_settings" {
  type = object({
    dc_name        = string
    cluster_name   = string
    datastore_name = string

  })
}

variable "vm_settings" {
  type = object({
    name            = string
    hostname        = string
    domain          = string
    num_cpus        = number
    memory          = number
    ipv4_address    = string
    ipv4_netmask    = number
    ipv4_gateway    = string
    dns_server_list = list(string)
    portgroup       = string
    diskname        = string
  })
}