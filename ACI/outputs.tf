output "vsphere_portgroup_name" {
  value = join(aci_epg_to_domain.demo_epg_to_vmm_domain.delimiter, [aci_tenant.demo_tenant.name, aci_application_profile.demo_ap.name, aci_application_epg.demo_epg.name])
}