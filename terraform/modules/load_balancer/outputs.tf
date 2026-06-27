output "load_balancer_id" {
  description = "ID of the load balancer"
  value       = azurerm_lb.this.id
}

output "backend_pool_id" {
  description = "ID of the backend address pool"
  value       = azurerm_lb_backend_address_pool.this.id
}

output "public_ip_address" {
  description = "Public IP address of the load balancer"
  value       = azurerm_public_ip.this.ip_address
}

output "fqdn" {
  description = "FQDN of the load balancer public IP"
  value       = azurerm_public_ip.this.fqdn
}
