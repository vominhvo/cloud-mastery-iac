variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "instance_count" {
  type = string
}

variable "resource_group_abbrevation" {
  type = string
}

variable "resource_group_profile" {
  type = string
}

variable "user_assigned_identity_abbrevation" {
  type = string
}

variable "user_assigned_identity_profile" {
  type = string
}

variable "vnet_combined_vars" {
  type = map(string)
  default = {
    virtual_network_abbrevation = ""
    virtual_network_profile     = ""
    virtual_ip_address          = ""
    subnet_abbrevation          = ""
  }
}
variable "virtual_ip_address" {
  type = list(string)
}

variable "list_subnet" {
  type = list(object({
    name           = string
    address_prefix = list(string)
  }))
}

variable "storage_combined_vars" {
  type = map(string)
  default = {
    storage_account_abbrevation   = ""
    storage_account_profile       = ""
    storage_container_abbrevation = ""
    storage_container_profile     = ""
  }
}

variable "account_app_service_combined_vars" {
  type = map(string)
  default = {
    app_service_abbrevation            = ""
    app_service_profile                = ""
    app_service_connection_abbrevation = ""
    app_service_connection_profile     = ""
    app_service_authentication         = ""
    app_service_plan_abbrevation       = ""
    app_service_plan_profile           = ""
    service_plan_sku                   = ""
    os_type                            = ""
    connect_to_db                      = false
    identity_type                      = ""
  }
}
variable "cosmosdb_combined_vars" {
  type = map(string)
  default = {
    cosmosdb_account_abbrevation      = ""
    cosmosdb_account_profile          = ""
    cosmosdb_database_abbrevation     = ""
    cosmosdb_database_profile         = ""
    cosmos_db_consistency_level       = ""
    cosmos_db_max_interval_in_seconds = ""
    cosmos_db_max_staleness_prefix    = ""
    cosmos_db_offer_type              = ""
    database_throughput               = ""
    first_geo_location                = ""
    second_geo_location               = ""
    default_identity_type             = ""
    identity_type                     = ""
  }
}

variable "key_vault_combined_vars" {
  type = map(string)
  default = {
    key_vault_location           = ""
    key_vault_abbrevation        = ""
    key_vault_profile            = ""
    key_vault_sku_name           = ""
    soft_delete_retention_days   = ""
    key_permissions              = ""
    secret_permissions           = ""
    storage_permissions          = ""
    key_vault_secret_abbrevation = ""
    key_vault_secret_profile     = ""
    key_vault_secret_value       = ""
    key_vault_key_abbrevation    = ""
    key_vault_key_profile        = ""
    key_vault_key_type           = ""
    key_vault_key_size           = ""
    time_before_expiry           = ""
    expire_after                 = ""
    notify_before_expiry         = ""
  }
}

variable "key_permissions" {
  type = list(string)
}

variable "secret_permissions" {
  type = list(string)
}

variable "storage_permissions" {
  type = list(string)
}

variable "key_opts" {
  type = list(string)
}


variable "service_bus_combined_vars" {
  type = map(string)
  default = {
    service_bus_abbrevation       = ""
    service_bus_profile           = ""
    service_bus_queue_abbrevation = ""
    service_bus_queue_profile     = ""
    sku_name                      = ""
  }
}
