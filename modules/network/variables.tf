variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "rglocation" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "vnet_cidr" {
  type        = string
  description = "CIDR block for the VNet"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}