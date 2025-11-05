# public IPs for firewalls (one per firewall)
resource "azurerm_public_ip" "fw_pip" {
  for_each            = var.firewalls
  name                = each.value.pip_name
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  
  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}

# firewalls
resource "azurerm_firewall" "fw" {
  for_each            = var.firewalls
  name                = each.key
  resource_group_name = var.rgname
  location            = var.location
  sku_name            = "AZFW_VNet"
  sku_tier            = each.value.sku_tier

  # find the firewall subnet inside the chosen vnet
  dynamic "ip_configuration" {
    for_each = [each.value] # single block
    content {
      name                 = "configuration"
      subnet_id            = data.azurerm_subnet.fw_subnet.id
      public_ip_address_id = azurerm_public_ip.fw_pip[each.key].id
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}
