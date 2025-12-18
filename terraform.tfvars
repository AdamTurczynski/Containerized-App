project_name        = "static-website"

resource_group_name = "rg-static-website-dev"

location_primary    = "westeurope"
location_secondary  = "northeurope"

vnet_name = "vnet-static-website-dev"
vnet_cidr = "10.0.0.0/16"

public_subnets = [
  "10.0.1.0/24", 
  "10.0.2.0/24"  
]

private_subnets = [
  "10.0.3.0/24", 
  "10.0.4.0/24"  
]

tags = {
  project     = "static-website"
  environment = "dev"
  owner       = "lukasz"
}
