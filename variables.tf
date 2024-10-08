variable "no_public_ip" {
  type        = bool
  default     = true
  description = "If Secure Cluster Connectivity (No Public IP) should be enabled. Default: true"
}

variable "rglocation" {
  type        = string
  default     = "southeastasia"
  description = "Location of resource group to create"
}

variable "dbfs_prefix" {
  type        = string
  default     = "dbfs"
  description = "Name prefix for DBFS Root Storage account"
}

## Workspace ##
variable "node_type" {
  type        = string
  default     = "Standard_DS3_v2"
  description = "Node type for created cluster"
}

variable "workspace_prefix" {
  type        = string
  default     = "adb"
  description = "Name prefix for Azure Databricks workspace"
}

variable "global_auto_termination_minute" {
  type        = number
  default     = 30
  description = "Auto-termination time for created cluster"
}

variable "cidr" {
  type        = string
  default     = "10.179.0.0/20"
  description = "Network range for created VNet"
<<<<<<< HEAD
  validation {
    condition     = can(cidrhost(var.cidr, 0))
    error_message = "Must be a valid IPv4 CIDR block address."
  }
=======
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
}

variable "tags" {
  type        = map(string)
<<<<<<< HEAD
  description = "A mapping of tags to assign to the resource"
=======
  description = "Optional tags to add to resources"
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
  default     = {}
}

variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
}
variable "azure_client_id" {
  description = "azure client id"
  type        = string
}

variable "azure_client_secret" {
  description = "azure client secret"
  type        = string
<<<<<<< HEAD
  sensitive   = true
=======
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
}

variable "azure_tenant_id" {
  description = "azure tenant id"
  type        = string
}

<<<<<<< HEAD

=======
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
variable "create_duration" {
  description = "Value of time wating per secound"
  type        = string
  default     = "30s"
}

### Key vaults ###
variable "environment" {
  description = "Environment name (e.g., dev, uat, prod)"
  type        = string
}

variable "sku_name" {
  description = "value"
<<<<<<< HEAD
  type        = string
  default     = "standard"
=======
  type = string
  default = "standard"
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
}

## Additional when need multi workspace ##
variable "create_additional_workspaces" {
  type    = bool
  default = true
}

variable "additional_workspace_count" {
  description = "Number of additional workspaces to create"
  type        = number
  default     = 0
}

variable "databricks_sku" {
  description = "The SKU to use for the Databricks workspace"
  type        = string
  default     = "premium"
<<<<<<< HEAD
  validation {
    condition     = contains(["standard", "premium", "trial"], var.databricks_sku)
    error_message = "Allowed values for databricks_sku are 'standard', 'premium', or 'trial'."
  }
=======
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
}
variable "vnet_id" {
  description = "The ID of the Virtual Network where this Databricks workspace should be created"
  type        = string
  default     = null
}

variable "private_subnet_name" {
  description = "The name of the Private Subnet within the Virtual Network"
  type        = string
  default     = null
}

variable "public_subnet_name" {
  description = "The name of the Public Subnet within the Virtual Network"
  type        = string
  default     = null
<<<<<<< HEAD
}

variable "prefix" {
  type        = string
  description = "Prefix for resource names"
=======
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
}