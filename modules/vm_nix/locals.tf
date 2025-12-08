# One entry per NIC / subnet combo
locals {
  vm_nics = flatten([
    for vm_key, vm in var.vm_config : [
      for nic_key, nic in vm.vnet_interface : {
        vm_key    = vm_key
        nic_key   = nic_key
        vm_name   = vm.name
        nic_name  = nic.name
        ip_config = nic.ip_configuration[0] # assuming one ip_config per NIC for now
      }
    ]
  ])

  # Turn into a map for for_each
  vm_nics_map = {
    for n in local.vm_nics :
    "${n.vm_key}-${n.nic_key}" => n
  }
}