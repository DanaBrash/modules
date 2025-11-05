data "azurerm_subnet" "fw_subnet" {
  name                 = var.firewalls["fw1"].subnet_name # I think just saying the first one is fine. Honestly we probably dont even need a map here at all, but I'm putting it just for in case. Code Review can decide.
  virtual_network_name = var.firewalls["fw1"].vnet_name
  resource_group_name  = var.rgname
}

