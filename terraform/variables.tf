variable "location" {
  type        = string
  description = "Azure region to deploy into"
  default     = "australiaeast"
}

variable "prefix" {
  type        = string
  description = "Prefix used for resource naming (pattern: {type}-{prefix})"
  default     = "jlg-webtier"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources"
  default = {
    environment = "dev"
    project     = "jlg-webtier"
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
  description = "Address prefixes for the web tier subnet"
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
  default     = "Standard_B1ls_v2"
}

variable "container_image" {
  type        = string
  description = "Container image pulled by cloud-init on each VMSS instance"
}

variable "domain_name_label" {
  type        = string
  description = "Globally unique DNS label for the load balancer public IP"
}
