### Add ANY-ANY for internal communication consumer side
resource "aci_epg_to_contract" "TF-IKS-Contract-ANY-ANY-con" {
  application_epg_dn = aci_application_epg.demo_epg.id
  contract_dn        = "uni/tn-common/brc-ANY-ANY"
  contract_type      = "consumer"
}

### Add ANY-ANY for internal communication provider side
resource "aci_epg_to_contract" "TF-IKS-Contract-ANY-ANY-pro" {
  application_epg_dn = aci_application_epg.demo_epg.id
  contract_dn        = "uni/tn-common/brc-ANY-ANY"
  contract_type      = "provider"
}

### Add contract to connect to L3our for internet access consumer side
resource "aci_epg_to_contract" "TF-IKS-Contract-Internet-con" {
  application_epg_dn = aci_application_epg.demo_epg.id
  contract_dn        = "uni/tn-common/brc-CTR_All-Out"
  contract_type      = "consumer"
}

### Add contract to connect to L3our for internet access consumer side
resource "aci_epg_to_contract" "TF-IKS-Contract-Internet-pro" {
  application_epg_dn = aci_application_epg.demo_epg.id
  contract_dn        = "uni/tn-common/brc-CTR_All-In"
  contract_type      = "provider"
}