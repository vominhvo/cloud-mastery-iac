output "cosmosdb_database_id" {
  value = azurerm_cosmosdb_sql_database.cosmosdb_database.id
}

output "cosmosdb_database_name" {
  value = azurerm_cosmosdb_sql_database.cosmosdb_database.name
}

output "cosmosdb_account_id" {
  value = azurerm_cosmosdb_account.cosmosdb_account.id
}

output "cosmosdb_account_name" {
  value = azurerm_cosmosdb_account.cosmosdb_account.name
}