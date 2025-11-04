locals {
  vnets = [
    {
      name          = "vnet1"
      address_space = ["10.10.0.0/16"]
    },
    {
      name          = "vnet2"
      address_space = ["10.20.0.0/16"]
    }
  ]


# using default is redundant with sample call from main at root, but used for portability
subnets = [
    # vnet1
    {
      vnet_name        = "vnet1"
      name             = "AzureFirewallSubnet" # required literal name for Azure Firewall
      address_prefixes = ["10.10.0.0/24"]
    },
    {
      vnet_name        = "vnet1"
      name             = "subnet1"
      address_prefixes = ["10.10.10.0/24"]
    },

    # vnet2
    {
      vnet_name        = "vnet2"
      name             = "AzureFirewallSubnet"
      address_prefixes = ["10.20.0.0/24"]
    },
    {
      vnet_name        = "vnet2"
      name             = "app"
      address_prefixes = ["10.20.10.0/24"]
    }
  ]
}