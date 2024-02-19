resource "azurerm_service_plan" "app_service_plan" {
  count               = var.exising_app_service ? 0 : 1
  name                = "${var.project_name}-${var.app_service_plan_abbrevation}-${var.app_service_plan_profile}-${var.environment}-${var.location}-${var.instance_count}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.service_plan_sku
  os_type             = var.os_type
  # zone_balancing_enabled = true
}

output "service_plan_id" {
  value = azurerm_service_plan.app_service_plan[0].id
}
