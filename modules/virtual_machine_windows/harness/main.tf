module "virtual_machine_windows" {
  source    = "../"
  rgname    = local.rgname
  location  = local.location
  subnet_id = data.azurerm_subnet.vm_subnet.id
  vm_config = var.vm_config
  tags      = var.tags
}
