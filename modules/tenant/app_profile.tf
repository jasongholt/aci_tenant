resource "aci_application_profile" "app_prof" {
  for_each = local.application_profiles
  name       = each.key
  tenant_dn  = aci_tenant.tenant.id
  depends_on = [aci_tenant.tenant]
}