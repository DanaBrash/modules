# Virtual Network Module

Create Azure virtual networks and subnets using a simple map driven interface. This module expects a resource group name and region. You pass a list of VNets and a list of Subnets keyed by the VNet name.

### readme created by chatgpt, use for overview and read the code

## Features

- Creates one or more VNets with address spaces you provide
- Creates one or more subnets and binds each to its parent VNet
- Exposes maps and lists for ids and names to make wiring other modules easy
- Supports tags applied to all resources

## Requirements

- Terraform >= 1.5
- AzureRM provider >= 3.100

## Usage

```hcl
module "vnet" {{
  source  = "./modules/virtual_network"
  rgname  = "rg-network-westus2"
  location = "West US 2"

  tags = {{
    Environment = "Development"
    Department  = "Payroll"
    CostCenter  = "8675309"
  }}

  vnets = [
    {{
      name          = "vnet1"
      address_space = ["10.10.0.0/16"]
    }},
    {{
      name          = "vnet2"
      address_space = ["10.20.0.0/16"]
    }}
  ]

  subnets = [
    // vnet1
    {{
      vnet_name        = "vnet1"
      name             = "web"
      address_prefixes = ["10.10.10.0/24"]
    }},
    {{ 
      vnet_name        = "vnet1"
      name             = "app"
      address_prefixes = ["10.10.20.0/24"]
    }},
    // vnet2
    {{
      vnet_name        = "vnet2"
      name             = "web"
      address_prefixes = ["10.20.10.0/24"]
    }}
  ]
}}
```

## Inputs

<!-- BEGIN_TF_DOCS -->
| Name | Description | Type | Default | Required |
| --- | --- | --- | --- | --- |
| location | The Azure region where resources will be created. | `string` | "West US 2" | no |
| rgname | The resource group name where resources will be created. | `string` |  | yes |
| tags | A map of tags to assign to the resources. | `map(string)` | | no |

  
| vnets | Virtual networks to create | `list(object({[]})` 

    {
      name          = "vnet1"
      address_space = ["10.10.0.0/16"]
    },
    {
      name          = "vnet2"
      address_space = ["10.20.0.0/16"]
    }
 `]})` 
 

| subnets | Subnets to create; vnet_name must match a vnet above | `list(object({[` 

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
      name             = "AzureFirewallSubnet"
      address_prefixes = ["10.20.0.0/24"]
    },
    {
      vnet_name        = "vnet2"
      name             = "app"
      address_prefixes = ["10.20.10.0/24"]
    }
`]})` 

<!-- END_TF_DOCS -->

## Outputs

<!-- BEGIN_TF_DOCS -->
| Name | Description |
| --- | --- |
| rgname | The resource group name  |
| vnets_by_name | Map keyed by VNet name with id, name, and address_space. |
| vnet_ids | Map of VNet ids keyed by VNet name. |
| vnet_names | List of all VNet names created. |
| subnets_by_key | Map keyed by 'vnet/subnet' with id, name, and address_prefixes. |
| subnet_ids | Map of subnet ids keyed by 'vnet/subnet'. |
| subnet_names | List of all subnet names created. |
<!-- END_TF_DOCS -->

## File layout

- `variables.tf` Module inputs
- `locals.tf` Useful computed maps used during resource creation
- `virtual_network.tf` VNet and Subnet resources
- `outputs.tf` Module outputs

## Notes

- Subnets must reference a VNet by name using `vnet_name`
- Address prefixes must not overlap within the same VNet
- Tags map is applied to all created resources

