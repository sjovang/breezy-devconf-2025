<!-- BEGIN_TF_DOCS -->
# Terraform demo

A small demo that deploys the demo network architecture

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azapi_resource.resource_group](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) (resource)
- [azapi_client_config.this](https://registry.terraform.io/providers/Azure/azapi/latest/docs/data-sources/client_config) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id)

Description: The subscription ID to use for the Azure provider

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name)

Description: The name of the environment

Type: `string`

Default: `"breezy-devconf-tf-demo"`

### <a name="input_location"></a> [location](#input\_location)

Description: Azure region for resources

Type: `string`

Default: `"swedencentral"`

### <a name="input_vnet_address_prefix"></a> [vnet\_address\_prefix](#input\_vnet\_address\_prefix)

Description: The address prefix for the virtual network

Type: `string`

Default: `"10.43.0.0/16"`

## Outputs

No outputs.

## Modules

The following Modules are called:

### <a name="module_nat_gateway"></a> [nat\_gateway](#module\_nat\_gateway)

Source: Azure/avm-res-network-natgateway/azurerm

Version: 0.2.1

### <a name="module_virtual_network"></a> [virtual\_network](#module\_virtual\_network)

Source: Azure/avm-res-network-virtualnetwork/azurerm

Version: 0.10.0
<!-- END_TF_DOCS -->