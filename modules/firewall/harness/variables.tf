variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "West US 2"
}

variable "rgname" {
  description = "Target resource group"
  type = string 
  default = "rg1"
}

variable "firewalls" {
  description = "Firewalls to deploy; subnet_name must be AzureFirewallSubnet inside the target vnet"
  type = map(object({
    vnet_name   = string
    subnet_name = string                      # required "AzureFirewallSubnet"
    pip_name    = string                      # public IP name to create/use
    sku_tier    = optional(string, "Premium") # Standard or Premium
  }))
  default = {
    fw1 = {
      vnet_name   = "vnet1"
      subnet_name = "AzureFirewallSubnet"
      pip_name    = "pip-fw1"
      sku_tier    = "Standard"
    }
  }
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

