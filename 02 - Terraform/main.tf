locals {
  tags = {
    DeployedBy  = data.azapi_client_config.this.object_id // we dont get user_principal_name directly. We can query this from entraid/msgraph if we want something more readable
    Description = "Deploy the demo architecture with Terraform. Use both azapi and azurerm providers as well as Azure Verified Modules"
    Environment = var.environment_name
  }
}

data "azapi_client_config" "this" {}

resource "azapi_resource" "resource_group" {
  type     = "Microsoft.Resources/resourceGroups@2025-04-01"
  name     = "rg-${var.environment_name}"
  location = var.location
  tags     = local.tags
}

resource "azurerm_network_security_group" "this" {
  location            = var.location
  name                = "nsg-${var.environment_name}"
  resource_group_name = azapi_resource.resource_group.name
  tags                = local.tags
}

module "nat_gateway" {
  source              = "Azure/avm-res-network-natgateway/azurerm"
  version             = "0.2.1"
  location            = azapi_resource.resource_group.location
  name                = "natgw-${var.environment_name}"
  resource_group_name = azapi_resource.resource_group.name
  tags                = local.tags
  enable_telemetry    = false
}

module "virtual_network" {
  source              = "Azure/avm-res-network-virtualnetwork/azurerm"
  version             = "0.10.0"
  address_space       = [var.vnet_address_prefix]
  location            = azapi_resource.resource_group.location
  name                = "vnet-${var.environment_name}"
  resource_group_name = azapi_resource.resource_group.name
  enable_telemetry    = false

  subnets = {
    frontend = {
      name             = "sn-frontend"
      address_prefixes = [cidrsubnet(var.vnet_address_prefix, 8, 0)]
      nat_gateway = {
        id = module.nat_gateway.resource_id
      }
      network_security_group = {
        id = azurerm_network_security_group.this.id
      }
    }
    backend = {
      name             = "sn-backend"
      address_prefixes = [cidrsubnet(var.vnet_address_prefix, 8, 1)]
      nat_gateway = {
        id = module.nat_gateway.resource_id
      }
      network_security_group = {
        id = azurerm_network_security_group.this.id
      }
    }
  }
}