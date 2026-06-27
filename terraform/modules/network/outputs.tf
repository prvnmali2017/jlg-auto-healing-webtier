output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.this.id
}

output "nsg_id" {
  description = "ID of the network security group"
  value       = azurerm_network_security_group.this.id
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "subnet_id" {
  description = "ID of the web tier subnet"
  value       = one(azurerm_virtual_network.this.subnet[*].id)
}
