locals {
  vnets_by_name = { for v in var.vnets : v.name => v }
  # key subnets by "vnet/name" so they’re unique and addressable
  subnets_by_key = {
    for s in var.subnets :
    "${s.vnet_name}/${s.name}" => s
  }
}