variable "location" {
  type        = string
  description = "Azure region for Container App"
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "acr_login_server" {
  type = string
}

variable "acr_username" {
  type      = string
  sensitive = true
}

variable "acr_password" {
  type      = string
  sensitive = true
}

variable "tags" {
  type = map(string)
}

variable "name" {
  type = string
}
