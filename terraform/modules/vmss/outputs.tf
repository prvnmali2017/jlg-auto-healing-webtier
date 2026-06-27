output "id" {
  description = "ID of the Linux VM scale set"
  value       = azurerm_linux_virtual_machine_scale_set.this.id
}

output "name" {
  description = "Name of the Linux VM scale set"
  value       = azurerm_linux_virtual_machine_scale_set.this.name
}
