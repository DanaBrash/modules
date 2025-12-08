resource "azurerm_network_interface" "vnet_interface" {
  for_each            = local.vm_nics_map

  name                = each.value.nic_name
  resource_group_name = var.rgname
  location            = var.location

  ip_configuration {
    name                          = each.value.ip_config.name
    subnet_id                     = var.subnet_ids[each.value.ip_config.subnet_name]
    private_ip_address_allocation = each.value.ip_config.private_ip_address_allocation
  }
}


resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = var.vm_config

  name                = each.value.name
  resource_group_name = var.rgname
  location            = var.location
  size                = each.value.size
  admin_username      = each.value.admin_username

  network_interface_ids = [
    # Example: pick the primary NIC for this VM
    azurerm_network_interface.vnet_interface["${each.key}-v_int1"].id
  ]

  admin_ssh_key {
    username   = each.value.admin_username
    public_key = file(each.value.admin_ssh_public_key_path)
  }

  os_disk {
    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }
}
