variable "kv_map" {
  description = "Map of key vault settings"
  type = map(object({
    name = string
    tenant_id = string
    rgname = string
    location = string
    sku_name = string
    rbac_authorization_enabled = bool
    enabled_for_disk_encryption = bool
    soft_delete_retention_days = number
    purge_protection_enabled   = bool
  }))
  default = {
    kv1 = {
    name = "cala-kv-1"
    tenant_id = ""
    rgname = "rg1"
    location = "westus2"
    sku_name = "standard"
    rbac_authorization_enabled = true
    enabled_for_disk_encryption = true
    soft_delete_retention_days = 7
    purge_protection_enabled   = false
    },
    kv2 = {
    name = "cala-kv-2"
    tenant_id = ""
    rgname = "rg1"
    location = "westus2"
    sku_name = "standard"
    rbac_authorization_enabled = true
    enabled_for_disk_encryption = true
    soft_delete_retention_days = 7
    purge_protection_enabled   = false
    }
  }
}

variable "key_vault_readers" {
  description = "List of user names to be assigned Key Vault Reader role"
  type        = list(string)
  default     = local.key_vault_readers
}

variable "key_vault_contributors" {
  description = "List of user names to be assigned Key Vault Contributor role"
  type        = list(string)
  default     = local.key_vault_contributors
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "West US 2"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {
    Environment = "Development"
    Department  = "Payroll"
    CostCenter  = "8675309"
  }
}

# tfvars obfuscated for privacy/security
variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}

variable "tenant_id" {
  description = "The Azure tenant ID."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the deployment."
  type        = string
}
