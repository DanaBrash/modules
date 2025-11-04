terraform {
  # set values in unpublished secrets.auto.tfvars
  backend "azurerm" {
    resource_group_name  = "env-rg"
    storage_account_name = "calabashtfstate"
    container_name       = "tfstate"
    key                  = "mod/terraform.tfstate"
  }
}

