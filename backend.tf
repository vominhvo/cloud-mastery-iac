terraform {
  backend "azurerm" {
    resource_group_name  = "projectx-rg-dev-eastus"
    storage_account_name = "testdemoterraform123456"
    container_name       = "terraform-tfstate"
    key                  = "workspace/terraform.tfstate"
  }
}
