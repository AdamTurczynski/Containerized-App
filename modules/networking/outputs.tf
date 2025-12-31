output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "public_subnet_primary_id" {
  value = azurerm_subnet.public_primary.id
}

output "public_subnet_secondary_id" {
  value = azurerm_subnet.public_secondary.id
}

output "private_subnet_primary_id" {
  value = azurerm_subnet.private_primary.id
}

output "private_subnet_secondary_id" {
  value = azurerm_subnet.private_secondary.id
}

