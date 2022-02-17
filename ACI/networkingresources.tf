### Add a new VRF to the Tenant
resource "aci_vrf" "demo_vrf" {
  tenant_dn              = aci_tenant.demo_tenant.id
  name                   = var.vrf.name
  pc_enf_pref            = "enforced"
  pc_enf_dir             = "ingress"
  bd_enforced_enable     = "no"
  ip_data_plane_learning = "enabled"
}

### Add a new Bridge Domain to the VRF and attach L3out
resource "aci_bridge_domain" "demo_bd" {
  tenant_dn                 = aci_tenant.demo_tenant.id
  name                      = var.bd.name
  bridge_domain_type        = "regular"
  arp_flood                 = "yes"
  limit_ip_learn_to_subnets = "yes"
  mcast_allow               = "no"
  host_based_routing        = "no"
  ip_learning               = "yes"
  unk_mac_ucast_act         = "proxy"
  unk_mcast_act             = "flood"
  v6unk_mcast_act           = "flood"
  multi_dst_pkt_act         = "bd-flood"
  unicast_route             = "yes"
  relation_fv_rs_ctx        = aci_vrf.demo_vrf.id
  relation_fv_rs_bd_to_out  = [var.bd.relation_fv_rs_bd_to_out]
}

# ### Add DHCP Relay Policy
# resource "aci_dhcp_relay_policy" "dhcp-relay-policy" {
#   tenant_dn = aci_tenant.demo_tenant.id
#   name      = "TF-IKS-Demo-DHCP_RelayPolicy"
#   mode      = "visible"
#   owner     = "tenant"
#   relation_dhcp_rs_prov {
#     addr = "10.1.100.251"
#     tdn  = "uni/tn-TN_VMs/ap-AP_VMs/epg-EPG_VMs"
#   }
# }

# ### Add DCHP Relay Label
# resource "aci_bd_dhcp_label" "dhcp-relay-label" {
#   bridge_domain_dn = aci_bridge_domain.demo_bd.id
#   name             = "TF-IKS-Demo-DHCP_RelayPolicy"
#   owner            = "tenant"
# }

### Add a new Subnet to Bridge Domain
resource "aci_subnet" "bd_subnet" {
  parent_dn = aci_bridge_domain.demo_bd.id
  ip        = var.bd.subnet_ip
  ctrl      = []
  scope     = ["public", "shared"]
  virtual   = "no"
}