data "azurerm_subnet" "vm_subnet" {
  name                 = local.subnet_name # I think just saying the first one is fine. Honestly we probably dont even need a map here at all, but I'm putting it just for in case. Code Review can decide.
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rgname
}

