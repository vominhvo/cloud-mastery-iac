locals {
  service_bus_abbrevation = var.combined_vars["service_bus_abbrevation"]
  service_bus_profile = var.combined_vars["service_bus_profile"]
  service_bus_queue_abbrevation = var.combined_vars["service_bus_queue_abbrevation"]
  service_bus_queue_profile = var.combined_vars["service_bus_queue_profile"]
  sku_name = var.combined_vars["sku_name"]
}
resource "azurerm_servicebus_namespace" "namespace" {
  name                = "${var.project_name}-${local.service_bus_abbrevation}-${local.service_bus_profile}-${var.environment}-${var.location}-${var.instance_count}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = local.sku_name
}

resource "azurerm_servicebus_queue" "queue" {
  name                = "${var.project_name}-${local.service_bus_queue_abbrevation}-${local.service_bus_queue_profile}-${var.environment}-${var.location}-${var.instance_count}"
  namespace_id      = azurerm_servicebus_namespace.namespace.id
}