variable "rgname" {
  description = "Single resource group definition."
  type        = string
  default     = "rg1"
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "West US 2"
}

variable "subnet_id" {
  description = "The ID of the subnet where the VM will be deployed."
  type        = string
}

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
      name                          = string
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
          name                          = "vnet_interface1"
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
  default     = {
    Environment = "Development"
    Department  = "Payroll"
    CostCenter  = "8675309"
  }
}