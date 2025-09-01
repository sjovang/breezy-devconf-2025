variable "vnet_address_prefix" {
  description = "The address prefix for the virtual network"
  default     = "10.43.0.0/16"
  type        = string
}

variable "environment_name" {
  description = "The name of the environment"
  default     = "breezy-devconf-tf-demo"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  default     = "swedencentral"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID to use for the Azure provider"
  type        = string
}
