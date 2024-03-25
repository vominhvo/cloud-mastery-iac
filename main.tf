
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

# config cosmosDB
# module "cosmosDB" {
#   source                            = "./modules/cosmos-db"
#   project_name                      = local.project_name
#   environment                       = local.environment
#   location                          = local.location
#   instance_count                    = local.instance_count
#   resource_group_name               = azurerm_resource_group.this.name
#   azurerm_user_assigned_identity_id = azurerm_user_assigned_identity.user_assigned_identity.id
#   combined_vars                     = var.cosmosdb_combined_vars
# }

#config keyvault
# module "key_vault" {
#   source              = "./modules/key-vaults"
#   project_name        = local.project_name
#   environment         = local.environment
#   location            = local.location
#   instance_count      = local.instance_count
#   resource_group_name = azurerm_resource_group.this.name
#   tenant_id           = data.azurerm_client_config.current.tenant_id
#   object_id           = data.azurerm_client_config.current.object_id
#   combined_vars       = var.key_vault_combined_vars
#   key_opts            = var.key_opts
#   key_permissions     = var.key_permissions
#   secret_permissions  = var.secret_permissions
#   storage_permissions = var.storage_permissions
# }

# config service bus
# module "service_bus" {
#   source              = "./modules/service-bus"
#   project_name        = local.project_name
#   environment         = local.environment
#   location            = local.location
#   instance_count      = local.instance_count
#   resource_group_name = azurerm_resource_group.this.name
#   combined_vars       = var.service_bus_combined_vars
# }

#config account service
# module "account_service" {
#   source                    = "./modules/app-services"
#   project_name              = local.project_name
#   environment               = local.environment
#   location                  = local.location
#   instance_count            = local.instance_count
#   resource_group_name       = azurerm_resource_group.this.name
#   user_assigned_identity_id = azurerm_user_assigned_identity.user_assigned_identity.id
#   cosmosdb_account_id       = ""
#   # cosmosdb_account_id           = module.cosmosDB.cosmosdb_account_id
#   combined_vars                 = var.account_app_service_combined_vars
#   service_plan_id               = ""
#   service_bus_connection_string = module.service_bus.primary_connection_string
#   subnet_id                     = module.network.subnet1_id
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
# module "k8s" {
#   source                 = "./modules/k8s"
#   host                   = module.kubernetes.host
#   client_certificate     = base64decode(module.kubernetes.client_certificate)
#   client_key             = base64decode(module.kubernetes.client_key)
#   cluster_ca_certificate = base64decode(module.kubernetes.cluster_ca_certificate)
#   github_token           = var.github_token
# }
