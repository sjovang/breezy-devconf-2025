terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  required_version = "~> 1.0"
}

provider "azapi" {
  enable_preflight = true // this gives us errors on azure policy validation before we run `terraform apply`
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}