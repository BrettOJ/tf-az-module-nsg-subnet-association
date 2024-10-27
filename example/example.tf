locals {
  naming_convention_info = {
    project_code = "project_code"
    env          = "env"
    zone         = "zone"
    tier         = "tier"
    name         = "name"
  }
   tags = {
    environment = "Production"
  }
}

module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags = {
      }
    }
  }
}

module "azure_virtual_network"  {
  source              = "git::https://github.com/BrettOJ/tf-az-module-virtual-network?ref=main"
  location            = var.location
  resource_group_name = module.resource_groups.rg_output[1].name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  naming_convention_info = local.naming_convention_info
  tags = local.tags

  }

module "azure_subnet" {
  source = "git::https://github.com/BrettOJ/tf-az-module-network-subnet?ref=main"
  resource_group_name  = module.resource_groups.rg_output[1].name
  virtual_network_name = module.azure_virtual_network.vnets_output.name
  location               = var.location
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
  create_nsg = var.create_nsg
  subnets = {
  001 = {
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = null
      private_endpoint_network_policies_enabled = null
      route_table_id    = null
      delegation  = null
    }
  }
}

module "nsg" {
  source                 = "git::https://github.com/BrettOJ/tf-az-module-network-nsg?ref=main"
  location               = var.location
  resource_group_name    = module.resource_groups.rg_output[1].name
  naming_convention_info = local.naming_convention_info

  security_rules = [
    {
      name                       = "allow_ssh"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
  tags = local.tags
}

module "azurerm_subnet_network_security_group_association" {
    source = "git::https://github.com/BrettOJ/tf-az-module-nsg-subnet-association?ref=main"
  subnet_id                 = module.azure_subnet.subnet_output[1].id
  network_security_group_id = module.nsg.nsg_output.id
}