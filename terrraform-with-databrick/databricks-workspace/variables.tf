variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "azure_client_id" {
  description = "Azure Client ID (Service Principal)"
  type        = string
}

variable "azure_client_secret" {
  description = "Azure Client Secret (Service Principal)"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "my-databricks-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
  default     = "my-databricks-workspace"
}

variable "databricks_sku" {
  description = "SKU of the Databricks workspace (standard, premium, trial)"
  type        = string
  default     = "standard"
}

# เพิ่มตัวแปรอื่นๆ ตามความต้องการของคุณ