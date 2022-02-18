vsphere_provider = {
  server   = "10.1.4.253"
  user     = "administrator@vsphere.local"
  password = "Eshelter2017!"
}

vcenter_settings = {
  dc_name        = "innovation-lab"
  cluster_name   = "hx-demo-cluster"
  datastore_name = "HX-Demo-DS1"
}

vm_settings = {
  name            = "tf-demo-vm"
  hostname        = "tf-demo-vm"
  domain          = "ciscocloud.com"
  num_cpus        = 1
  memory          = 1024
  ipv4_address    = "10.30.1.11"
  ipv4_netmask    = 24
  ipv4_gateway    = "10.30.1.254"
  dns_server_list = ["10.1.4.251"]
  portgroup       = "TN_demotenant=demo_ap=demo_epg" # module.ACI.vsphere_portgroup_name
  diskname        = "disk0"
}