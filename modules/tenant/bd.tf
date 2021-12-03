resource "aci_bridge_domain" "bd" {
  for_each                  = local.bridge_domains
  name                      = each.key
  tenant_dn                 = aci_tenant.tenant.id
  unicast_route             = each.value.route
  arp_flood                 = each.value.arp_flood
  unk_mac_ucast_act         = each.value.l2_unicast_flood
  limit_ip_learn_to_subnets = "yes"
  relation_fv_rs_ctx        = aci_vrf.vrfs[each.value.vrf].id
  depends_on                = [aci_vrf.vrfs]
}

resource "aci_subnet" "ip" {
    for_each             = local.bridge_domains
    parent_dn            = aci_bridge_domain.bd[each.key].id
    ip                   = each.value.subnet
    scope                = each.value.scope
}