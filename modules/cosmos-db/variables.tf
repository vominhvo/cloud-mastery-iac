variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "instance_count" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "azurerm_user_assigned_identity_id" {
  type = string
}

variable "combined_vars" {
  type = map(string)
}