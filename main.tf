
locals {
  project_name   = var.project_name
  environment    = var.environment
  location       = var.region
  instance_count = var.instance_count
}

#config azure resource group
resource "azurerm_resource_group" "this" {
  name     = "${local.project_name}-${var.resource_group_abbrevation}-${var.resource_group_profile}-${local.environment}-${local.location}-${local.instance_count}"
  location = local.location
}

#config azure user assigned identity
resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = "${var.project_name}-${var.user_assigned_identity_abbrevation}-${var.user_assigned_identity_profile}-${var.environment}-${local.location}-${var.instance_count}"
  location            = local.location
  resource_group_name = azurerm_resource_group.this.name
}

#config virtual network
# module "network" {
#   source              = "./modules/network"
#   project_name        = local.project_name
#   environment         = local.environment
#   location            = local.location
#   instance_count      = local.instance_count
#   resource_group_name = azurerm_resource_group.this.name
#   combined_vars       = var.vnet_combined_vars
#   list_subnet         = var.list_subnet
#   virtual_ip_address  = var.virtual_ip_address
# }

#config k8s cluster
module "kubernetes" {
  source                 = "./modules/kubernetes"
  location               = local.location
  resource_group_name    = azurerm_resource_group.this.name
  project_name           = local.project_name
  environment            = local.environment
  combined_vars          = var.aks_combined_vars
  user_assigned_identity = azurerm_user_assigned_identity.user_assigned_identity.id
}
