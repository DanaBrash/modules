

module "vnet" {
  source    = "../"
  rgname    = var.rgname
  location  = var.location
  vnets     = local.vnets
  subnets   = local.subnets
    tags      = {
        Environment = "Harness"
        Department  = "FooBucket"
        CostCenter  = "1234567"
    }
}   


