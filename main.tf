resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location_primary

  tags = var.tags
}


module "nat_gateway" {
  source = "./modules/nat"

  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location_primary

  nat_gateway_name = "${var.project_name}-natgw"
  public_ip_name   = "${var.project_name}-natgw-pip"

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

module "acr" {
  source = "./modules/acr"

  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location_primary

acr_name = replace("${var.project_name}acr", "-", "")


  tags = var.tags
}
module "container_app" {
  source = "./modules/container-app"

  name                = "hello-world-app"
  location            = var.location_primary
  resource_group_name = azurerm_resource_group.rg.name
 subnet_id = module.networking.private_subnet_primary_id

  acr_login_server = module.acr.acr_login_server
  acr_username     = module.acr.acr_admin_username
  acr_password     = module.acr.acr_admin_password
  tags = local.tags
}


resource "azurerm_public_ip" "appgw_pip" {
  name                = "appgw-pip"
  location            = var.location_primary
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"

  tags = local.tags
}
module "application_gateway" {
  source = "./modules/app-gateway"

  name                = "static-website-agw"
  location            = var.location_primary
  resource_group_name = azurerm_resource_group.rg.name

  subnet_id    = module.networking.public_subnet_primary_id
  public_ip_id = azurerm_public_ip.appgw_pip.id
  backend_fqdn = "example.com"

  log_analytics_workspace_id = module.log_analytics.id
  tags                       = local.tags
}

module "log_analytics" {
  source = "./modules/log-analytics"

  name                = "law-static-website"
  location            = var.location_primary
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}
