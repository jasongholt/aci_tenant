terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "1.0.1"
    }
  }
}

resource "aci_tenant" "tenant" {
  name = local.name
}
output "tenant_id" {
    value = "${aci_tenant.tenant.id}"
}