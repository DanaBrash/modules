resource "azurerm_virtual_network" "vnets" {
  for_each            = local.vnets_by_name
  name                = each.value.name
  resource_group_name = var.rgname
  location            = var.location
  address_space       = each.value.address_space

  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
  
}

resource "azurerm_subnet" "subnets" {
  for_each             = local.subnets_by_key
  name                 = each.value.name
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.vnets[each.value.vnet_name].name
  address_prefixes     = each.value.address_prefixes
}
