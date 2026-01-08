
resource "azurerm_container_app_environment" "env" {
    timeouts {
    create = "90m"
    update = "90m"
    delete = "90m"
  }
  name                       = "${var.name}-env"
  location                   = var.location
  resource_group_name        = var.resource_group_name
log_analytics_workspace_id = var.log_analytics_workspace_id


  infrastructure_subnet_id = var.subnet_id

  tags = var.tags
}
resource "azurerm_container_app" "app" {
  name                         = var.name
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  ingress {
    external_enabled = true
    target_port      = 8080
    transport        = "http"
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
      min_replicas = 1
  max_replicas = 1
    container {
      
      name   = "hello-world"
      image = "${var.acr_login_server}/hello-aca:v1"


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


