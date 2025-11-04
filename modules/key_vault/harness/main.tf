terraform {
  required_version = ">=1.11.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.38.0"
    }
  }
}

resource "azurerm_resource_group" "resource_groups" {
  name     = local.rgname
  location = local.location
} 


module "key_vault" {
  source = "../"
  kv_map = {
    kv1 = {
      name                        = local.key_vault_name
      tenant_id                   = var.tenant_id
      rgname                      = local.rgname
      location                    = local.location
      sku_name                    = "standard"
      rbac_authorization_enabled  = true
      enabled_for_disk_encryption = true
      soft_delete_retention_days  = 7
      purge_protection_enabled    = false
    }
  }
  key_vault_readers      = local.key_vault_readers
  key_vault_contributors = local.key_vault_contributors
  domain_name            = var.domain_name
}
