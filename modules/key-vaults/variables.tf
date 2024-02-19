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

variable "object_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "combined_vars" {
  type = map(string)
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
