variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  description = "Public subnet for Application Gateway"
  type        = string
}

variable "public_ip_id" {
  description = "Public IP for Application Gateway frontend"
  type        = string
}

variable "backend_fqdn" {
  description = "Temporary backend FQDN"
  type        = string
}

variable "tags" {
  type = map(string)
}
variable "log_analytics_workspace_id" {
  type = string
}
variable "ssl_cert_password" {
  type      = string
  sensitive = true
}
