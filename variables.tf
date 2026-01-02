variable "project_name" {
  description = "Project name used for naming resources and tags"
  type        = string
}


variable "resource_group_name" {
  description = "Name of the resource group where resources will be created"
  type        = string
}

variable "location_primary" {
  description = "Primary Azure region (e.g. westeurope)"
  type        = string
}

variable "location_secondary" {
  description = "Secondary Azure region (e.g. northeurope)"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR for VNet address space"
  type        = string
}

variable "public_subnets" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}
variable "containerapps_subnet" {
  description = "CIDR for Container Apps dedicated subnet"
  type        = string
}
