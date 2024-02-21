locals {
  key_vault_location           = var.combined_vars["key_vault_location"]
  key_vault_abbrevation        = var.combined_vars["key_vault_abbrevation"]
  key_vault_profile            = var.combined_vars["key_vault_profile"]
  key_vault_sku_name           = var.combined_vars["key_vault_sku_name"]
  soft_delete_retention_days   = var.combined_vars["soft_delete_retention_days"]
  key_vault_secret_abbrevation = var.combined_vars["key_vault_secret_abbrevation"]
  key_vault_secret_profile     = var.combined_vars["key_vault_secret_profile"]
  key_vault_secret_value       = var.combined_vars["key_vault_secret_value"]
  key_vault_key_abbrevation    = var.combined_vars["key_vault_key_abbrevation"]
  key_vault_key_profile        = var.combined_vars["key_vault_key_profile"]
  key_vault_key_type           = var.combined_vars["key_vault_key_type"]
  key_vault_key_size           = var.combined_vars["key_vault_key_size"]
  time_before_expiry           = var.combined_vars["time_before_expiry"]
  expire_after                 = var.combined_vars["expire_after"]
  notify_before_expiry         = var.combined_vars["notify_before_expiry"]
}


resource "azurerm_key_vault" "key_vault" {
  name                = "${var.project_name}${local.key_vault_abbrevation}${local.key_vault_profile}${var.environment}${local.key_vault_location}${var.instance_count}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id
  sku_name            = local.key_vault_sku_name

  soft_delete_retention_days = local.soft_delete_retention_days
  purge_protection_enabled   = false
}


resource "azurerm_key_vault_access_policy" "access_policy" {
  key_vault_id    = azurerm_key_vault.key_vault.id
  tenant_id       = var.tenant_id
  object_id       = var.object_id
  key_permissions = var.key_permissions

  secret_permissions = var.secret_permissions

  storage_permissions = var.storage_permissions
}

resource "azurerm_key_vault_secret" "key_vault_secret" {
  name         = "${var.project_name}-${local.key_vault_secret_abbrevation}-${local.key_vault_secret_profile}-${var.environment}-${var.location}-${var.instance_count}"
  value        = local.key_vault_secret_value
  key_vault_id = azurerm_key_vault.key_vault.id
  depends_on   = [azurerm_key_vault_access_policy.access_policy]
}

resource "azurerm_key_vault_key" "key_vault_key" {
  name         = "${var.project_name}-${local.key_vault_key_abbrevation}-${local.key_vault_key_profile}-${var.environment}-${var.location}-${var.instance_count}"
  key_type     = local.key_vault_key_type
  key_size     = local.key_vault_key_size
  key_vault_id = azurerm_key_vault.key_vault.id
  key_opts     = var.key_opts
  rotation_policy {
    automatic {
      time_before_expiry = local.time_before_expiry
    }

    expire_after         = local.expire_after
    notify_before_expiry = local.notify_before_expiry
  }
  depends_on = [azurerm_key_vault_access_policy.access_policy]
}

