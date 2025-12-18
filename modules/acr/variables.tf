variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region for ACR"
  type        = string
}

variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
}

variable "sku" {
  description = "ACR pricing tier"
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
