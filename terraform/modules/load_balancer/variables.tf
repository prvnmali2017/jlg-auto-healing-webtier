variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public IP address"
}

variable "load_balancer_name" {
  type        = string
  description = "Name of the load balancer"
}

variable "backend_pool_name" {
  type        = string
  description = "Name of the backend address pool"
}

variable "frontend_ip_configuration_name" {
  type        = string
  description = "Name of the load balancer frontend IP configuration"
}

variable "domain_name_label" {
  type        = string
  description = "Globally unique DNS label for the public IP"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to load balancer resources"
}
