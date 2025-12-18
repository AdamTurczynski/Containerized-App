variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location_primary" {
  description = "Primary Azure region"
  type        = string
}

variable "location_secondary" {
  description = "Secondary Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR for VNet address space"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "nat_gateway_id" {
  description = "NAT Gateway ID to attach to private subnets"
  type        = string
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
