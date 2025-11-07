# show the code from the VM harness combined with the VNET and Subnet.  Letting resoure_groups.tf create the RG and calling the name

variable "vm_config" {
  description = "Configuration map for the virtual machine."
  type = map(object({
    name                         = string
    size                         = string
    admin_username               = string
    admin_password               = string
    os_disk_caching              = string
    os_disk_storage_account_type = string
    vnet_interface = map(object({
      name = string
      ip_configuration = list(object({
        name                          = string
        private_ip_address_allocation = string
      }))
    }))

    image_publisher = string
    image_offer     = string
    image_sku       = string
    image_version   = string
  }))
  default = {
    vm1 = {
      name                         = "vm1"
      size                         = "Standard_B2ms"
      admin_username               = "adminuser"
      admin_password               = "P@ssw0rd1234!"
      os_disk_caching              = "ReadWrite"
      os_disk_storage_account_type = "Standard_LRS"
      vnet_interface = {
        v_int1 = {
          name = "vnet_interface1"
          ip_configuration = [{
            name                          = "ipconfig1"
            private_ip_address_allocation = "Dynamic"
          }]
        }
      }
      image_publisher = "MicrosoftWindowsServer"
      image_offer     = "WindowsServer"
      image_sku       = "2019-Datacenter"
      image_version   = "latest"
    }
  }
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default = {
    Environment = "Development"
    Department  = "Payroll"
    CostCenter  = "8675309"
  }
}

variable "firewalls" {
  description = "Firewalls to deploy; subnet_name must be AzureFirewallSubnet inside the target vnet"
  type = map(object({
    vnet_rgname = string
    vnet_name   = string
    subnet_name = string                      # required "AzureFirewallSubnet"
    pip_name    = string                      # public IP name to create/use
    sku_tier    = optional(string, "Premium") # Standard or Premium
  }))
  default = {
    fw1 = {
      vnet_rgname = "rg_mod"
      vnet_name   = "vnet1"
      subnet_name = "AzureFirewallSubnet"
      pip_name    = "pip-fw1"
      sku_tier    = "Standard"
    }
  }
}

data "azurerm_subnet" "fw_subnet" {
  name                 = var.firewalls["fw1"].subnet_name # I think just saying the first one is fine. Honestly we probably dont even need a map here at all, but I'm putting it just for in case. Code Review can decide.
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rgname
  depends_on           = [azurerm_resource_group.rg, module.vnet]
}

data "azurerm_subnet" "vm_subnet" {
  name                 = local.subnet_name # I think just saying the first one is fine. Honestly we probably dont even need a map here at all, but I'm putting it just for in case. Code Review can decide.
  virtual_network_name = local.vnet_name
  resource_group_name  = local.rgname
  depends_on           = [azurerm_resource_group.rg, module.vnet]
}

# Create the VNETs and Subnets
locals {
  # must pre-exist.  Handle in calling module or otherwise. make sure you know your target or fetch it otherwise
  rgname      = azurerm_resource_group.rg["rg1"].name # I could just put the name here, but this makes the dependency explicit
  fw_rgname   = azurerm_resource_group.rg["rg_fw"].name
  location    = "West US 2"
  vnet_name   = "vnet1"
  subnet_name = "subnet1"

  vnets = [
    {
      name          = "vnet1"
      address_space = ["10.10.0.0/16"]
    },
    {
      name          = "vnet2"
      address_space = ["10.20.0.0/16"]
    }
  ]

  # using default is redundant with sample call from main at root, but used for portability
  subnets = [
    # vnet1
    {
      vnet_name        = "vnet1"
      name             = "AzureFirewallSubnet" # required literal name for Azure Firewall
      address_prefixes = ["10.10.0.0/24"]
    },
    {
      vnet_name        = "vnet1"
      name             = "subnet1"
      address_prefixes = ["10.10.10.0/24"]
    },

    # vnet2
    {
      vnet_name        = "vnet2"
      name             = "v2_subnet1"
      address_prefixes = ["10.20.0.0/24"]
    },
    {
      vnet_name        = "vnet2"
      name             = "app"
      address_prefixes = ["10.20.10.0/24"]
    }
  ]

}

# Create VNETs and Subnets
module "vnet" {
  source   = "./modules/virtual_network"
  rgname   = azurerm_resource_group.rg["rg1"].name
  location = local.location
  vnets    = local.vnets
  subnets  = local.subnets

  tags = var.tags
}

# Create FW
# firewalls
module "azurerm_firewall" {
  source    = "./modules/firewall"
  location  = local.location
  rgname    = local.fw_rgname
  firewalls = var.firewalls
  tags      = var.tags
}

# TODO: Make FW Policies

# TODO: Make UDR for FW

# Create VM
module "virtual_machine_windows" {
  source    = "./modules/virtual_machine_windows"
  rgname    = local.rgname
  location  = local.location
  subnet_id = data.azurerm_subnet.vm_subnet.id
  vm_config = var.vm_config
  tags      = var.tags
}


# can terraform apply -target null_resource.vm_deploy to put a new VM in full context of VNET and FW
resource "null_resource" "vm_deploy" {
  depends_on = [module.vnet, module.azurerm_firewall, module.virtual_machine_windows]
}
