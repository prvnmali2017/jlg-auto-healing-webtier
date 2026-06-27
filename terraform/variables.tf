variable "location" {
  type        = string
  description = "Azure region to deploy into"
  default     = "australiaeast"
}

variable "prefix" {
  type        = string
  description = "Prefix used for resource naming (pattern: {type}-{prefix})"
  default     = "global360-webtier"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources"
  default = {
    environment = "dev"
    project     = "global360-webtier"
    managed_by  = "terraform"
  }
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  type        = list(string)
  description = "Address prefixes for the web tier subnet (10.0.1.0/24 — VMSS subnet within the VNet)"
  default     = ["10.0.1.0/24"]
}

variable "vmss_instance_count" {
  type        = number
  description = "Number of VMSS instances (N+1 capacity requires at least 2)"
  default     = 2

  validation {
    condition     = var.vmss_instance_count >= 2
    error_message = "vmss_instance_count must be at least 2 for N+1 capacity."
  }
}

variable "vmss_sku" {
  type        = string
  description = "VMSS SKU"
  default     = "Standard_B2ls_v2"
}

variable "vmss_zones" {
  type        = list(string)
  description = "Availability zones for VMSS — spread instances across zones for zone-level HA"
  default     = ["1", "2"]
}

variable "container_image" {
  type        = string
  description = "Container image pulled by cloud-init on each VMSS instance"
  default     = "ghcr.io/prvnmali2017/global360-webtier:latest"
}

variable "domain_name_label" {
  type        = string
  description = "Globally unique DNS label for the load balancer public IP"
  default     = "global360-webtier-dev"
}
