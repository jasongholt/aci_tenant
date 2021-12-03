
resource "aci_application_epg" "epga" {
  for_each               = local.epga
  name                   = each.value.name
  application_profile_dn = aci_application_profile.app_prof[each.value.application_profile].id
  relation_fv_rs_bd      = aci_bridge_domain.bd[each.value.bridge_domain].id
  depends_on             = [aci_bridge_domain.bd, aci_application_profile.app_prof]
}

resource "aci_application_epg" "epgb" {
  for_each               = local.epgb
  name                   = each.value.name
  application_profile_dn = aci_application_profile.app_prof[each.value.application_profile].id
  relation_fv_rs_bd      = aci_bridge_domain.bd[each.value.bridge_domain].id
  depends_on             = [aci_bridge_domain.bd, aci_application_profile.app_prof]
}