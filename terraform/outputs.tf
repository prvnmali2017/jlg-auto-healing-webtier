output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.network.resource_group_name
}

output "load_balancer_public_ip" {
  description = "Public IP address of the load balancer"
  value       = module.load_balancer.public_ip_address
}

output "load_balancer_fqdn" {
  description = "FQDN of the load balancer public IP"
  value       = module.load_balancer.fqdn
}

output "vmss_id" {
  description = "ID of the Linux VM scale set"
  value       = module.vmss.id
}

output "vmss_instance_count" {
  description = "Configured VMSS instance count"
  value       = var.vmss_instance_count
}

output "web_url" {
  description = "URL to reach the web tier after apply"
  value       = "http://${module.load_balancer.public_ip_address}"
}
