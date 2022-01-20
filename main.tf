#Declare the terraform providers that are required for your resources and modules to work.  This module uses
# the Ciscodevnet aci provider.
terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "1.0.1"
    }
  }
}

# This Provider block uses credentials from the credentials.tf file that will need to be created with the values:
# variable "user" {
#   description = "Login information"
#   type        = map
#   default     = {
#     username = "<user>"
#     password = "<password>"
#     url      = "<hhttps://url>"
#   }
# }

provider "aci" {
  # APIC Username
  username = var.user.username
  # APIC Password
  password = var.user.password
  # APIC URL
  url      = var.user.url
  insecure = true
}

# The following module takes input variables and creates a configuration that is the base for 2 different applicatoins
#across 2 different setups.  with 1 tenant, 2 VRF's, 1 BD per vrf
# 2 EPG per BD, 1 Subnet per BD, and contracts for a 2 tier web app.  Please update the variables to meet your desired
# configuration state. 

module "my_tenant" {
    source                = "./modules/tenant"
    tenant_name           = "hashi-demo"
    vrfs                  = ["vrf_a"]
    bridge_domains = {
      app_a_bd = {
        routing = true
        vrf     = "vrf_a"
        subnet = "192.168.10.1/24"
        scope = ["public"]
      }
    }
   application_profiles = ["app_a_ap"]
   epga = {
    web_epg = {
      name                = "web_epg"
      application_profile = "app_a_ap"
      bridge_domain       = "app_a_bd"
    },
    db_epg = {
      name                = "db_epg"
      application_profile = "app_a_ap"
      bridge_domain       = "app_a_bd"
    }
   }
  filters_a = {
    filter_https = {
      filter   = "https",
      entry    = "https",
      protocol = "tcp",
      port     = "443"
    },
    filter_sql = {
      filter   = "sql",
      entry    = "sql",
      protocol = "tcp",
      port     = "3306",
    }
  }
  contracts_a = {
    contract_web_a = {
          contract = "web_a",
          subject  = "https_a",
          filter   = "filter_https"
        },
    contract_sql_a = {
          contract = "sql_a",
          subject  = "sql_a",
          filter   = "filter_sql"
        }
  }
  epga_contracts = {
    terraform_one = {
          epg           = "web_epg",
          contract      = "contract_sql_a",
          contract_type = "consumer" 
        },
    terraform_two = {
          epg           = "db_epg",
          contract      = "contract_sql_a",
          contract_type = "provider" 
    },
    terraform_three = {
          epg           = "web_epg",
          contract      = "contract_web_a",
          contract_type = "provider" 
    }
  }
}
  

  


  
  



