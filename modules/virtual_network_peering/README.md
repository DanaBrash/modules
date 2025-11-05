# Virtual Network Peering module

## Purpose
This is designed to take two VNETs and peer them together. 

## Hub/Spoke
By manipulating the variables you can determine which would be the hub and which the spoke, as I define them, by which one allows allow_gateway_transit and use_remote_gateways.

Generally speaking your hub will allow transit and not use a remote gateway (it will have the gateway) whereas the spoke will use the hub's remote gateway and block gateway transit

## Variables (default list)

```
{
    rgname                       = "rg1"
    name                         = "vnet1"
    peering_name                 = "vnet1-to-vnet2"  # hub
    id                           = ""
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    allow_virtual_network_access = true
    use_remote_gateways          = false
},
{
    rgname                       = "rg2"
    name                         = "vnet2"
    peering_name                 = "vnet2-to-vnet1" # spoke
    id                           = ""
    allow_forwarded_traffic      = true
    allow_gateway_transit        = false
    allow_virtual_network_access = true
    use_remote_gateways          = true
}
```

## requires networks already created.
Requires that one of the vnets actually has a remote gateway (vng) installed before the other can enable UseRemoteGateway=true

#### TODO:
Getting the vnet IDs could be handled in code where the vnets are called. Perhaps flatten variables in locals, perhaps call directly from main.tf.

remote_virtual_network_id = var.peering_vnets[0].id 

could easily be
remote_virtual_network_id = data.vnets[0].id

or some such.  

