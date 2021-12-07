#this file defins the top level Tennant name and tenant id

#Define the version and required Terraform Provider
terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "1.0.1"
    }
  }
}

#Define the Tenant Configuration
resource "aci_tenant" "tenant" {
  name = local.name
}

#Output the Datasorce name for the Tenant to be used across the modules
output "tenant_id" {
    value = "${aci_tenant.tenant.id}"
}