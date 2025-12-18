resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = var.location_primary
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]

  tags = var.tags
}

resource "azurerm_subnet" "public_primary" {
  name                 = "${var.vnet_name}-public-primary"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.public_subnets[0]]

}

resource "azurerm_subnet" "public_secondary" {
  name                 = "${var.vnet_name}-public-secondary"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.public_subnets[1]]
}

resource "azurerm_subnet" "private_primary" {
  name                 = "${var.vnet_name}-private-primary"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.private_subnets[0]]

}

resource "azurerm_subnet" "private_secondary" {
  name                 = "${var.vnet_name}-private-secondary"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.private_subnets[1]]

}

resource "azurerm_subnet_nat_gateway_association" "primary" {
  subnet_id      = azurerm_subnet.private_primary.id
  nat_gateway_id = var.nat_gateway_id
}

resource "azurerm_subnet_nat_gateway_association" "secondary" {
  subnet_id      = azurerm_subnet.private_secondary.id
  nat_gateway_id = var.nat_gateway_id
}
