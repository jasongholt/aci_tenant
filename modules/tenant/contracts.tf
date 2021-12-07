# Define an ACI Filter Resource.
resource "aci_filter" "terraform_filter_a" {
    for_each    = local.filters_a
    tenant_dn   = aci_tenant.tenant.id
    description = "This is filter ${each.key} created by terraform"
    name        = each.value.filter
}

# Define an ACI Filter Entry Resource.
resource "aci_filter_entry" "terraform_filter_entry_a" {
    for_each      = local.filters_a
    filter_dn     = aci_filter.terraform_filter_a[each.key].id
    name          = each.key
    ether_t       = "ipv4"
    prot          = each.value.protocol
    d_from_port   = each.value.port
    d_to_port     = each.value.port
}
resource "aci_filter" "terraform_filter_b" {
    for_each    = local.filters_b
    tenant_dn   = aci_tenant.tenant.id
    description = "This is filter ${each.key} created by terraform"
    name        = each.value.filter
}

# Define an ACI Filter Entry Resource.
resource "aci_filter_entry" "terraform_filter_entry_b" {
    for_each      = local.filters_b
    filter_dn     = aci_filter.terraform_filter_b[each.key].id
    name          = each.key
    ether_t       = "ipv4"
    prot          = each.value.protocol
    d_from_port   = each.value.port
    d_to_port     = each.value.port
}
# Define an ACI Contract Resource.
resource "aci_contract" "terraform_contract_a" {
    for_each      = local.contracts_a
    tenant_dn     = aci_tenant.tenant.id
    name          = each.key
    scope         = "tenant"
    description   = "Contract created using Terraform"
}
# Define an ACI Contract Resource.
resource "aci_contract" "terraform_contract_b" {
    for_each      = local.contracts_b
    tenant_dn     = aci_tenant.tenant.id
    name          = each.key
    scope         = "tenant"
    description   = "Contract created using Terraform"
}
# Define an ACI Contract Subject Resource.
resource "aci_contract_subject" "terraform_contract_subject_a" {
    for_each                      = local.contracts_a
    contract_dn                   = aci_contract.terraform_contract_a[each.key].id
    name                          = each.value.subject
    relation_vz_rs_subj_filt_att  = [aci_filter.terraform_filter_a[each.value.filter].id]
}
# Define an ACI Contract Subject Resource.
resource "aci_contract_subject" "terraform_contract_subject_b" {
    for_each                      = local.contracts_b
    contract_dn                   = aci_contract.terraform_contract_b[each.key].id
    name                          = each.value.subject
    relation_vz_rs_subj_filt_att  = [aci_filter.terraform_filter_b[each.value.filter].id]
}
# Assignes the Contracts to the EPG for the web epgs
resource "aci_epg_to_contract" "terraform_epgweb_contract" {
    for_each           = local.epga_contracts
    application_epg_dn = aci_application_epg.epga[each.value.epg].id
    contract_dn        = aci_contract.terraform_contract_a[each.value.contract].id
    contract_type      = each.value.contract_type
}
# Assignes the Contracts to the EPG for the db epgs
resource "aci_epg_to_contract" "terraform_epgdb_contract" {
    for_each           = local.epgb_contracts
    application_epg_dn = aci_application_epg.epgb[each.value.epg].id
    contract_dn        = aci_contract.terraform_contract_b[each.value.contract].id
    contract_type      = each.value.contract_type
}