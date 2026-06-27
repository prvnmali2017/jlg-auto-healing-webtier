variable "name" {
  type        = string
  description = "Name of the Linux VM scale set"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "instance_count" {
  type        = number
  description = "Number of VMSS instances"
}

variable "sku" {
  type        = string
  description = "VMSS SKU"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for VMSS network interfaces"
}

variable "backend_pool_ids" {
  type        = list(string)
  description = "Load balancer backend address pool IDs"
}

variable "admin_username" {
  type        = string
  description = "Admin username for VMSS instances"
  default     = "adminuser"
}

variable "public_key" {
  type        = string
  description = "SSH public key for admin access"
}

variable "custom_data" {
  type        = string
  description = "Base64-encoded cloud-init configuration"
}

variable "zones" {
  type        = list(string)
  description = "Availability zones for VMSS instances"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to VMSS resources"
}
