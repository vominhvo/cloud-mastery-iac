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

variable "user_assigned_identity_id" {
  type = string
}

variable "cosmosdb_account_id" {
  type = string
}

variable "combined_vars" {
  type = map(string)
}

variable "service_plan_id" {
  type = string
}

variable "service_bus_connection_string" {
  type = string
}

variable "subnet_id" {
  type = string
}
