resource "azurerm_application_gateway" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }
ssl_policy {
  policy_type          = "Predefined"
  policy_name          = "AppGwSslPolicy20220101"
}   
  gateway_ip_configuration {
    name      = "gateway-ipcfg"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontend-port-80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = var.public_ip_id
  }

  backend_address_pool {
    name  = "backend-pool"
    fqdns = [var.backend_fqdn]
  }

  probe {
    name                = "health-probe"
    protocol            = "Http"
    path                = "/health"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    pick_host_name_from_backend_http_settings = true

    match {
      status_code = ["200-399"]
    }
  }

  backend_http_settings {
    name                  = "http-settings-8080"
    protocol              = "Http"
    port                  = 8080
    request_timeout       = 30
      cookie_based_affinity = "Disabled"
    pick_host_name_from_backend_address = true
    probe_name            = "health-probe"
  }

  http_listener {
    name                           = "http-listener-80"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "frontend-port-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener-80"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-settings-8080"
    priority                   = 100
  }

  tags = var.tags
}
resource "azurerm_monitor_diagnostic_setting" "appgw" {
  name                       = "diag-appgw"
  target_resource_id         = azurerm_application_gateway.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  depends_on = [
    azurerm_application_gateway.this
  ]
  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }

  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }

  enabled_log {
    category = "ApplicationGatewayFirewallLog"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
