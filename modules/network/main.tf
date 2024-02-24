locals {
  virtual_network_abbrevation = var.combined_vars["virtual_network_abbrevation"]
  virtual_network_profile     = var.combined_vars["virtual_network_profile"]
  subnet_abbrevation          = var.combined_vars["subnet_abbrevation"]
}
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_name}-${local.virtual_network_abbrevation}-${local.virtual_network_profile}-${var.environment}-${var.location}-${var.instance_count}"
  address_space       = var.virtual_ip_address
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    env = var.environment
  }
}

resource "azurerm_subnet" "subnet" {
  for_each = {
    for index, sn in var.list_subnet :
    index => sn
  }
  name                 = "${var.project_name}-${local.subnet_abbrevation}-${each.value.name}-${var.environment}-${var.location}-${var.instance_count}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefix
  resource_group_name  = var.resource_group_name
  delegation {
    name = "subnet-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
