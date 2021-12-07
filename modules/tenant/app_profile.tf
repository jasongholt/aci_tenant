# This Resource creates the application profiles on the APIC Controller.  Variables are
# controlled in the main.tf file in the / directory


resource "aci_application_profile" "app_prof" {
  for_each = local.application_profiles
  name       = each.key
  tenant_dn  = aci_tenant.tenant.id
  depends_on = [aci_tenant.tenant]
}