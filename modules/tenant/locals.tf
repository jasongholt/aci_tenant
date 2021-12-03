locals {
  name                  = var.tenant_name
  vrfs                  = var.vrfs
  bridge_domains        = local.bds
  application_profiles  = var.application_profiles
  epga                 = var.epga
  epgb                 = var.epgb
  
  filters_a              = var.filters_a
  
  filters_b              = var.filters_b

  contracts_a            = var.contracts_a

  contracts_b            = var.contracts_b
  epga_contracts = var.epga_contracts

  epgb_contracts = var.epgb_contracts
}

locals {
  bds = tomap({
    for bd_key, bd in var.bridge_domains : bd_key => {
      vrf              = bd.vrf
      arp_flood        = bd.routing ? "no" : "yes"
      l2_unicast_flood = bd.routing ? "proxy" : "flood"
      route            = bd.routing ? "yes" : "no"
      subnet           = bd.subnet
      scope            = bd.scope
    }
  })
}