variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "nsg_name" {
  type        = string
  description = "Name of the network security group"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the web tier subnet"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "subnet_prefix" {
  type        = list(string)
  description = "Address prefixes for the web tier subnet"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to network resources"
}
