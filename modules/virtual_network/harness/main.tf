

module "vnet" {
  source   = "../"
  rgname   = var.rgname
  location = var.location
  vnets    = local.vnets
  subnets  = local.subnets

  tags = var.tags
}


