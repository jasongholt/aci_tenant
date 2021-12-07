#The Variables file is going to be used to fedine the variables objects, 
#and the individual variables that will be used in each of the resources and across the different modules

variable "tenant_name" {
  type        = string
  description = "The name of our new Tenant managed by Terraform"

}
variable "tenant_id" {
    default = ""
    }

variable "vrfs" {
  type        = set(string)
  description = "List of VRFs we want our new tenant to have"
  default     = []
}

variable "bridge_domains" {
  type = map(object({
    routing = bool,
    vrf     = string,
    subnet = string,
    scope   = list(string)
  }))
  description = "Map of bridge domains to create and their associated VRFs"
  default     = {}
}

variable "application_profiles" {
  type        = set(string)
  description = "List of application profiles belonging to the Tenant"
  default     = []
}

variable "epga" {
  type = map(object({
    name                = string,
    application_profile = string,
    bridge_domain       = string,
  }))
  description = "Map of EPGs to create and their associated bridge-domains"
  default     = {}
}

variable "epgb" {
  type = map(object({
    name                = string,
    application_profile = string,
    bridge_domain       = string,
  }))
  description = "Map of EPGs to create and their associated bridge-domains"
  default     = {}
}

variable "filters_a" {
  type = map(object({
    filter = string,
    entry  = string,
    protocol = string,
    port = string
  }))
  description = "Map of filters to create and their associated subjects"
  default     = {}
}
variable "filters_b" {
  type = map(object({
    filter = string,
    entry  = string,
    protocol = string,
    port = string
  }))
  description = "Map of filters to create and their associated subjects"
  default     = {}
}

variable "contracts_a" {
  type = map(object({
    contract = string,
    subject  = string,
    filter = string,
  }))
  description = "Map of filters to create and their associated subjects"
  default     = {}
}

variable "contracts_b" {
  type = map(object({
    contract = string,
    subject  = string,
    filter = string,
  }))
  description = "Map of filters to create and their associated subjects"
  default     = {}
}
variable "epga_contracts" {
  type = map(object({
    epg = string,
    contract  = string,
    contract_type = string,
  }))
  description = "Map of filters to create and their associated subjects"
  default     = {}
}

variable "epgb_contracts" {
  type = map(object({
    epg = string,
    contract  = string,
    contract_type = string,
  }))
  description = "Map of filters to create and their associated subjects"
  default     = {}
}

