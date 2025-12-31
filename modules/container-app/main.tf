resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.name}-law"
location = var.location

  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}
resource "azurerm_container_app_environment" "env" {
  name                       = "${var.name}-env"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  infrastructure_subnet_id = var.subnet_id

  tags = var.tags
}
resource "azurerm_container_app" "app" {
  name                         = var.name
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  ingress {
    external_enabled = false
    target_port      = 8080
    transport        = "auto"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  secret {
    name  = "acr-password"
    value = var.acr_password
  }

  registry {
    server               = var.acr_login_server
    username             = var.acr_username
    password_secret_name = "acr-password"
  }

  template {
    container {
      name   = "hello-world"
      image  = "${var.acr_login_server}/hello-world:1.0"

      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "PORT"
        value = "8080"
      }
    }
  }

  tags = var.tags
}

