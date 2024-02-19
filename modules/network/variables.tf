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

variable "combined_vars" {
  type = map(string)
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