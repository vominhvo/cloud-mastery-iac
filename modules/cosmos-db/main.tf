locals {
  cosmosdb_account_abbrevation      = var.combined_vars["cosmosdb_account_abbrevation"]
  cosmosdb_account_profile          = var.combined_vars["cosmosdb_account_profile"]
  cosmosdb_database_abbrevation     = var.combined_vars["cosmosdb_database_abbrevation"]
  cosmosdb_database_profile         = var.combined_vars["cosmosdb_database_profile"]
  cosmos_db_consistency_level       = var.combined_vars["cosmos_db_consistency_level"]
  cosmos_db_max_interval_in_seconds = var.combined_vars["cosmos_db_max_interval_in_seconds"]
  cosmos_db_max_staleness_prefix    = var.combined_vars["cosmos_db_max_staleness_prefix"]
  cosmos_db_offer_type              = var.combined_vars["cosmos_db_offer_type"]
  database_throughput               = var.combined_vars["database_throughput"]
  first_geo_location                = var.combined_vars["first_geo_location"]
  second_geo_location               = var.combined_vars["second_geo_location"]
  default_identity_type             = var.combined_vars["default_identity_type"]
  identity_type                     = var.combined_vars["identity_type"]
}
resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = "${var.project_name}-${local.cosmosdb_account_abbrevation}-${local.cosmosdb_account_profile}-${var.environment}-${var.location}-${var.instance_count}"
  location            = var.location
  resource_group_name = var.resource_group_name

  geo_location {
    location          = local.first_geo_location
    failover_priority = 1
  }

  geo_location {
    location          = local.second_geo_location
    failover_priority = 0
  }

  consistency_policy {
    consistency_level       = local.cosmos_db_consistency_level
    max_interval_in_seconds = local.cosmos_db_max_interval_in_seconds
    max_staleness_prefix    = local.cosmos_db_max_staleness_prefix
  }

  offer_type = local.cosmos_db_offer_type

  default_identity_type = join("=", [local.default_identity_type, var.azurerm_user_assigned_identity_id])

  identity {
    type         = local.identity_type
    identity_ids = [var.azurerm_user_assigned_identity_id]
  }
}

resource "azurerm_cosmosdb_sql_database" "cosmosdb_database" {
  name                = "${var.project_name}-${local.cosmosdb_database_abbrevation}-${local.cosmosdb_database_profile}-${var.environment}-${var.location}-${var.instance_count}"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name
  throughput          = local.database_throughput
}
