# firewalls
module "azurerm_firewall" {
  source          = "../"
  location        = var.location
  rgname          = var.rgname
  firewalls       = var.firewalls
  tags            = var.tags
}
