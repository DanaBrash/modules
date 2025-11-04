
variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "West US 2"
}

variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}

variable "tenant_id" {
  description = "The Azure tenant ID."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the deployment."
  type        = string
}

variable "rgname" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "rg1"
}

variable "peering_vnets" {
  description = "List of VNETs to peer"
  type = list(object({
    rgname                       = string
    name                         = string
    peering_name                 = string
    id                           = string
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    allow_virtual_network_access = bool
    use_remote_gateways          = bool
    tags                         = map(string)
  }))
  default = [
    {
      rgname                       = "rg1"
      name                         = "vnet1"
      peering_name                 = "vnet1-to-vnet2"
      id                           = "/subscriptions/c1b1f12b-41c7-4fb3-b5ac-02e36ce1331e/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet1"
      allow_forwarded_traffic      = true
      allow_gateway_transit        = true
      allow_virtual_network_access = true
      use_remote_gateways          = false
      tags                         = {}
    },
    {
      rgname                       = "rg1"
      name                         = "vnet2"
      peering_name                 = "vnet2-to-vnet1"
      id                           = "/subscriptions/c1b1f12b-41c7-4fb3-b5ac-02e36ce1331e/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet2"
      allow_forwarded_traffic      = true
      allow_gateway_transit        = false
      allow_virtual_network_access = true
      use_remote_gateways          = true
      tags                         = {}
    }
  ]
}
