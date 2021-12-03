terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "1.0.1"
    }
  }
}

# Configure the provider with your Cisco APIC credentials.
provider "aci" {
  # APIC Username
  username = var.user.username
  # APIC Password
  password = var.user.password
  # APIC URL
  url      = var.user.url
  insecure = true
}

module "my_tenant" {
    source                = "../modules/tenant"
    tenant_name           = "hashi-demo"
    vrfs                  = ["vrf_a", "vrf_b"]
    bridge_domains = {
      app_a_bd = {
        routing = true
        vrf     = "vrf_a"
        subnet = "192.168.10.1/24"
        scope = ["public"]
      },
      app_b_bd = {
        routing = false
        vrf     = "vrf_b"
        subnet = "192.168.10.3/24"
        scope = ["shared"]
      }
    }
   application_profiles = ["app_a_ap", "app_b_ap"]
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
  epgb = {
    web_epg = {
      name                = "web_epg"
      application_profile = "app_b_ap"
      bridge_domain       = "app_b_bd"
    },
    db_epg = {
      name                = "db_epg"
      application_profile = "app_b_ap"
      bridge_domain       = "app_b_bd"
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
  filters_b = {
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
  contracts_b = {
    contract_web_b = {
          contract = "web_b",
          subject  = "https_b",
          filter   = "filter_https"
        },
    contract_sql_b = {
          contract = "sql_b",
          subject  = "sql_b",
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
  epgb_contracts = {
    terraform_one = {
          epg           = "web_epg",
          contract      = "contract_sql_b",
          contract_type = "consumer" 
        },
    terraform_two = {
          epg           = "db_epg",
          contract      = "contract_sql_b",
          contract_type = "provider" 
    },
    terraform_three = {
          epg           = "web_epg",
          contract      = "contract_web_b",
          contract_type = "provider" 
    }
  }
}
  

  


  
  



