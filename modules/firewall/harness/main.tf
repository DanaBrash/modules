# firewalls
module "azurerm_firewall" {
  source          = "../"
  location        = var.location
  rgname          = var.rgname
  firewalls       = var.firewalls
  domain_name     = var.domain_name
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  tags            = var.tags
}
