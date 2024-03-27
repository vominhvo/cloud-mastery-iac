locals {
  azure_kubernetes_abbrevation = var.combined_vars["azure_kubernetes_abbrevation"]
  azure_kubernetes_profile     = var.combined_vars["azure_kubernetes_profile"]
  dns_prefix                   = var.combined_vars["dns_prefix"]
  default_node_pool_name       = var.combined_vars["default_node_pool_name"]
  node_count                   = var.combined_vars["node_count"]
  vm_size                      = var.combined_vars["vm_size"]
  identity_type                = var.combined_vars["identity_type"]
  node_pool_abbrevation        = var.combined_vars["node_pool_abbrevation"]
  node_pool_profile            = var.combined_vars["node_pool_profile"]
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${var.project_name}-${local.azure_kubernetes_abbrevation}-${local.azure_kubernetes_profile}-${var.environment}-${var.location}-${var.instance_count}"
  resource_group_name = var.resource_group_name
  location            = var.location
  dns_prefix          = local.azure_kubernetes_abbrevation

  default_node_pool {
    name       = local.default_node_pool_name
    node_count = local.node_count
    vm_size    = local.vm_size
  }

  identity {
    type = local.identity_type
  }

}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}

#resource "azurerm_kubernetes_cluster_node_pool" "example" {
#  name                  = "${var.project_name}-${local.node_pool_abbrevation}-${local.node_pool_profile}-${var.environment}-${var.location}-${var.instance_count}"
#  kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
#  vm_size               = local.vm_size
#  node_count            = 1
#
#}
