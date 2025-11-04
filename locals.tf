locals {
  suffix           = ["mod"]
  projName         = "study"
  primary_location = var.location       # e.g., "East US"
  replica_location = "westcentralus" # e.g., "West US"
  admin_user       = "modadmin"
  admin_password   = "P@ssw0rd1234!@#$" # store in KV in real use

    resource_groups = {
        rg1 = {
            name_suffix     = ""
            location = var.location
        },
        rg_fw = {
            name_suffix     = "fw"
            location = var.location
        }
    }
}