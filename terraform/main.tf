locals {
  resource_names = {
    resource_group               = "rg-${var.prefix}"
    nsg                          = "nsg-${var.prefix}"
    vnet                         = "vnet-${var.prefix}"
    subnet                       = "snet-${var.prefix}"
    public_ip                    = "pip-${var.prefix}"
    load_balancer                = "lbe-${var.prefix}"
    backend_pool                 = "beap-${var.prefix}"
    frontend_ip_configuration    = "feip-${var.prefix}"
  }
}

module "network" {
  source = "./modules/network"

  resource_group_name = local.resource_names.resource_group
  nsg_name            = local.resource_names.nsg
  vnet_name           = local.resource_names.vnet
  subnet_name         = local.resource_names.subnet
  location            = var.location
  address_space       = var.address_space
  subnet_prefix       = var.subnet_prefix
  tags                = var.tags
}

module "load_balancer" {
  source = "./modules/load_balancer"

  resource_group_name            = module.network.resource_group_name
  location                       = var.location
  public_ip_name                 = local.resource_names.public_ip
  load_balancer_name             = local.resource_names.load_balancer
  backend_pool_name              = local.resource_names.backend_pool
  frontend_ip_configuration_name = local.resource_names.frontend_ip_configuration
  domain_name_label              = var.domain_name_label
  tags                           = var.tags
}
