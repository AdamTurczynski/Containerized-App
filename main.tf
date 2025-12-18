resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location_primary

  tags = var.tags
}


module "nat_gateway" {
  source = "./modules/nat"

  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location_primary

  nat_gateway_name = "${var.project_name}-${var.environment}-natgw"
  public_ip_name   = "${var.project_name}-${var.environment}-natgw-pip"

  tags = var.tags
}

module "networking" {
  source = "./modules/networking"

  resource_group_name = azurerm_resource_group.rg.name
  location_primary    = var.location_primary
  location_secondary  = var.location_secondary

  vnet_name   = var.vnet_name
  vnet_cidr   = var.vnet_cidr

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  nat_gateway_id = module.nat_gateway.nat_gateway_id

  tags = var.tags
}