
variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "West US 2"
}

variable "rgname" {
  description = "The resource group name where resources will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {
    Environment = "sandbox"
    Department  = "dbrash-test"
    CostCenter  = "8675309"
  }
}

variable "vnets" {
  description = "Virtual networks to create"
  type = list(object({
    name          = string
    address_space = list(string)
  }))
  default = [
    {
      name          = "vnet1"
      address_space = ["172.16.0.0/27"]
    },
    {
      name          = "vnet2"
      address_space = ["172.16.0.32/27"]
    },
    {
      name          = "vnet3"
      address_space = ["172.16.0.64/27"]
    }
  ]
}

variable "subnet_ids" {
  description = "Map of subnet names to their IDs"
  type        = map(string)
}

variable "subnets" {
  description = "Subnets to create; vnet_name must match a vnet above"
  type = list(object({
    vnet_name        = string
    name             = string
    address_prefixes = list(string)
  }))
  default = [
    # vnet1
    {
      vnet_name        = "vnet1"
      name             = "subnet1"
      address_prefixes = ["172.16.0.0/27"]
    },

    # vnet2
    {
      vnet_name        = "vnet2"
      name             = "subnet2"
      address_prefixes = ["172.16.0.32/27"]
    },

    # vnet3
    {
      vnet_name        = "vnet3"
      name             = "subnet3"
      address_prefixes = ["172.16.0.64/27"]
    }
  ]
}

variable "vm_config" {
  description = "Configuration map for linux virtual machines."
  type = map(object({
    name                         = string
    size                         = string
    admin_username               = string
    admin_ssh_public_key_path    = string
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
      name                         = "vm1-machine"
      size                         = "Standard_F2"
      admin_username               = "adminuser"
      admin_ssh_public_key_path    = "~/.ssh/id_rsa.pub"

      os_disk_caching              = "ReadWrite"
      os_disk_storage_account_type = "Standard_LRS"

      vnet_interface = {
        nic1 = {
          name = "vm1-nic"
          ip_configuration = [
            {
              name                          = "vm1-ipconfig"
              private_ip_address_allocation = "Dynamic"
            }
          ]
        }
      }

      image_publisher = "Canonical"
      image_offer     = "0001-com-ubuntu-server-jammy"
      image_sku       = "22_04-lts"
      image_version   = "latest"
    }

    vm2 = {
      name                         = "vm2-machine"
      size                         = "Standard_B2ms"
      admin_username               = "adminuser"
      admin_ssh_public_key_path    = "~/.ssh/id_rsa.pub"

      os_disk_caching              = "ReadWrite"
      os_disk_storage_account_type = "Standard_LRS"

      vnet_interface = {
        nic1 = {
          name = "vm2-nic"
          ip_configuration = [
            {
              name                          = "vm2-ipconfig"
              private_ip_address_allocation = "Dynamic"
            }
          ]
        }
      }

      image_publisher = "Canonical"
      image_offer     = "0001-com-ubuntu-server-jammy"
      image_sku       = "22_04-lts"
      image_version   = "latest"
    }

    vm3 = {
      name                         = "vm3-machine"
      size                         = "Standard_DS1_v2"
      admin_username               = "adminuser"
      admin_ssh_public_key_path    = "~/.ssh/id_rsa.pub"

      os_disk_caching              = "ReadWrite"
      os_disk_storage_account_type = "Standard_LRS"

      vnet_interface = {
        nic1 = {
          name = "vm3-nic"
          ip_configuration = [
            {
              name                          = "vm3-ipconfig"
              private_ip_address_allocation = "Dynamic"
            }
          ]
        }
      }

      image_publisher = "Canonical"
      image_offer     = "0001-com-ubuntu-server-jammy"
      image_sku       = "22_04-lts"
      image_version   = "latest"
    }
  }
}
