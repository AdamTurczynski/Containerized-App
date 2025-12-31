output "container_app_ingress_fqdn" {
  value = azurerm_container_app.app.ingress[0].fqdn
}
