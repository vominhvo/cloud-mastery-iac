locals {
  app_service_abbrevation            = var.combined_vars["app_service_abbrevation"]
  app_service_profile                = var.combined_vars["app_service_profile"]
  app_service_connection_abbrevation = var.combined_vars["app_service_connection_abbrevation"]
  app_service_connection_profile     = var.combined_vars["app_service_connection_profile"]
  app_service_authentication         = var.combined_vars["app_service_authentication"]
  app_service_plan_abbrevation       = var.combined_vars["app_service_plan_abbrevation"]
  app_service_plan_profile           = var.combined_vars["app_service_plan_profile"]
  service_plan_sku                   = var.combined_vars["service_plan_sku"]
  os_type                            = var.combined_vars["os_type"]
  connect_to_db                      = var.combined_vars["connect_to_db"]
  identity_type                      = var.combined_vars["identity_type"]
}

module "app_service_plan" {
  source                       = "../app-service-plan"
  exising_app_service          = var.service_plan_id != "" ? true : false
  project_name                 = var.project_name
  environment                  = var.environment
  location                     = var.location
  instance_count               = var.instance_count
  resource_group_name          = var.resource_group_name
  app_service_plan_abbrevation = local.app_service_plan_abbrevation
  app_service_plan_profile     = local.app_service_plan_profile
  service_plan_sku             = local.service_plan_sku
  os_type                      = local.os_type
}

resource "azurerm_linux_web_app" "app_service" {
  name                = "${var.project_name}-${local.app_service_abbrevation}-${local.app_service_profile}-${var.environment}-${var.location}-${var.instance_count}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id != "" ? var.service_plan_id : module.app_service_plan.service_plan_id
  identity {
    type         = local.identity_type
    identity_ids = [var.user_assigned_identity_id]
  }
  app_settings = {
    "SERVICE_BUS_CONNECTION_STRING" = var.service_bus_connection_string
  }

  site_config {
    always_on = false //always_on cannot be set to true when using Free, F1, D1 Sku
  }
}

# resource "azurerm_app_service_connection" "app_service_connection" {
#   count              = local.connect_to_db ? 0 : 1
#   name               = "${var.project_name}-${local.app_service_connection_abbrevation}-${local.app_service_connection_profile}-${var.environment}-${var.location}-${var.instance_count}"
#   app_service_id     = azurerm_linux_web_app.app_service.id
#   target_resource_id = var.cosmosdb_account_id
#   authentication {
#     type = local.app_service_authentication
#   }
# }

resource "azurerm_app_service_virtual_network_swift_connection" "network" {
  app_service_id = azurerm_linux_web_app.app_service.id
  subnet_id      = var.subnet_id
}
