data "azurerm_subnet" "fw_subnet" {
  name                 = var.firewalls["fw1"].subnet_name
  virtual_network_name = var.firewalls["fw1"].vnet_name
  resource_group_name  = var.rgname
}

