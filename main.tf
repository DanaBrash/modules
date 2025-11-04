terraform {
  required_version = ">=1.11.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.38.0"
    }
  }
}


module "naming" {
  source = "git::https://github.com/DanaBrash/calabashnaming.git"
  suffix = local.suffix
}
