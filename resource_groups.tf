resource "azurerm_resource_group" "rg" {
  for_each = local.resource_groups
  name     = "${module.naming.resource_group.name}${each.value.name_suffix == "" ? "" : "-${each.value.name_suffix}"}"
  location = each.value.location
}