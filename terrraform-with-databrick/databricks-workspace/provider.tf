terraform {
  required_providers {
    databricks = {
        source = "databricks/databricks"
        version = "~> 1.21.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.workspace.id
  azure_client_id = var.azure_client_id
  azure_client_secret = var.azure_client_secret
  azure_tenant_id = var.azure_tenant_id
}

provider "azurerm" {
  features {}
  client_id = var.azure_client_id
  client_secret = var.azure_client_secret
  tenant_id = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
}