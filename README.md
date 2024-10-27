# tf-az-module-nsg-subnet-association
Terraform module to create an Azure subnet network security group association
Associates a [Network Security Group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) with a [Subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) within a [Virtual Network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network).

## [Example Usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#example-usage)

```hcl
resource "azurerm_resource_group" "example" { name = "example-resources" location = "West Europe" } resource "azurerm_virtual_network" "example" { name = "example-network" address_space = ["10.0.0.0/16"] location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name } resource "azurerm_subnet" "example" { name = "frontend" resource_group_name = azurerm_resource_group.example.name virtual_network_name = azurerm_virtual_network.example.name address_prefixes = ["10.0.2.0/24"] } resource "azurerm_network_security_group" "example" { name = "example-nsg" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name security_rule { name = "test123" priority = 100 direction = "Inbound" access = "Allow" protocol = "Tcp" source_port_range = "*" destination_port_range = "*" source_address_prefix = "*" destination_address_prefix = "*" } } resource "azurerm_subnet_network_security_group_association" "example" { subnet_id = azurerm_subnet.example.id network_security_group_id = azurerm_network_security_group.example.id }
```

## [Argument Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#argument-reference)

The following arguments are supported:

-   [`network_security_group_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#network_security_group_id) - (Required) The ID of the Network Security Group which should be associated with the Subnet. Changing this forces a new resource to be created.
    
-   [`subnet_id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#subnet_id) - (Required) The ID of the Subnet. Changing this forces a new resource to be created.
    

## [Attributes Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#attributes-reference)

In addition to the Arguments listed above - the following Attributes are exported:

-   [`id`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#id) - The ID of the Subnet.

## [Timeouts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#timeouts)

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

-   [`create`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#create) - (Defaults to 30 minutes) Used when creating the Subnet Network Security Group Association.
-   [`read`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#read) - (Defaults to 5 minutes) Used when retrieving the Subnet Network Security Group Association.
-   [`delete`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#delete) - (Defaults to 30 minutes) Used when deleting the Subnet Network Security Group Association.

## [Import](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association#import)

Subnet `<->` Network Security Group Associations can be imported using the `resource id` of the Subnet, e.g.

```shell
terraform import azurerm_subnet_network_security_group_association.association1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/virtualNetworks/myvnet1/subnets/mysubnet1
```