output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = azurerm_nat_gateway.this.id
}

output "public_ip_id" {
  description = "ID of the NAT Gateway public IP"
  value       = azurerm_public_ip.nat_pip.id
}
