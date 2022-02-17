### Create a new AP under the given Tenant
resource "aci_application_profile" "demo_ap" {
  tenant_dn = aci_tenant.demo_tenant.id
  name      = var.application_profile.name
}

### Create a new EPG under the AP in the Tenant
resource "aci_application_epg" "demo_epg" {
  application_profile_dn = aci_application_profile.demo_ap.id
  name                   = var.epg.name
  pc_enf_pref            = "unenforced"
  pref_gr_memb           = "exclude"
  flood_on_encap         = "disabled"
  shutdown               = "no"
  relation_fv_rs_bd      = aci_bridge_domain.demo_bd.id
}

### Assign the VMM Domain to the EPG -> creates a Portgroup in vCenter through ACI-vCenter integration
resource "aci_epg_to_domain" "demo_epg_to_vmm_domain" {
  application_epg_dn    = aci_application_epg.demo_epg.id
  tdn                   = var.epg.epg_to_domain_tdn
  binding_type          = "none"
  allow_micro_seg       = "false"
  delimiter             = "="
  instr_imedcy          = "immediate"
  res_imedcy            = "immediate"
  vmm_allow_promiscuous = "reject"
  vmm_forged_transmits  = "reject"
  vmm_mac_changes       = "reject"
  num_ports             = "128"
}

