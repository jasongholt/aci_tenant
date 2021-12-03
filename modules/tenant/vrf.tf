resource "aci_vrf" "vrfs" {
  for_each   = local.vrfs
  name       = each.key
  tenant_dn  = aci_tenant.tenant.id
  depends_on = [aci_tenant.tenant]

}
