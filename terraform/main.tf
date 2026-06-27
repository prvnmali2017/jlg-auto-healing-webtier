locals {
  resource_names = {
    resource_group = "rg-${var.prefix}"
    nsg            = "nsg-${var.prefix}"
    vnet           = "vnet-${var.prefix}"
    subnet         = "snet-${var.prefix}"
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
