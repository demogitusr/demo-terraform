# Main Workspace Outputs
output "main_workspace_resource_id" {
  description = "The Azure resource ID of the main Databricks workspace"
  value       = azurerm_databricks_workspace.myworkspace.id
}

output "main_workspace_url" {
  description = "The URL of the main Databricks workspace"
  value       = "https://${azurerm_databricks_workspace.myworkspace.workspace_url}/"
}

# Additional Workspaces Outputs
output "additional_workspace_urls" {
  description = "The URLs of additional Databricks workspaces"
  value = {
    for i, workspace in azurerm_databricks_workspace.additional_workspaces :
    "workspace_${i + 2}" => "https://${workspace.workspace_url}/"
  }
}

output "additional_workspace_ids" {
  description = "The Azure resource IDs of additional Databricks workspaces"
  value = {
    for i, workspace in azurerm_databricks_workspace.additional_workspaces :
    "workspace_${i + 2}" => workspace.id
  }
}

# Cluster Outputs
output "auto_scaling_cluster_id" {
  description = "The ID of the auto-scaling cluster created by the module"
  value       = module.auto_scaling_cluster_example.cluster_id
}

# Key Vault Outputs
output "key_vault_name" {
  description = "The name of the Azure Key Vault"
  value       = azurerm_key_vault.key.name
}

output "key_vault_id" {
  description = "The Azure resource ID of the Key Vault"
  value       = azurerm_key_vault.key.id
}

# Combined Workspace Information
output "all_workspace_info" {
  description = "Combined information for all workspaces (main and additional)"
  value = merge(
    {
      "main_workspace" = {
        id   = azurerm_databricks_workspace.myworkspace.id
        url  = "https://${azurerm_databricks_workspace.myworkspace.workspace_url}/"
        name = azurerm_databricks_workspace.myworkspace.name
      }
    },
    {
      for i, workspace in azurerm_databricks_workspace.additional_workspaces :
      "workspace_${i + 2}" => {
        id   = workspace.id
        url  = "https://${workspace.workspace_url}/"
        name = workspace.name
      }
    }
  )
}

# Resource Group Output
output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.this.name
}

# Tags Output
output "resource_tags" {
  description = "Tags applied to the resources"
  value       = var.tags
}

# Managed Identity Output (if used)
output "databricks_managed_identity" {
  description = "The principal ID of the Databricks workspace managed identity"
  value       = azurerm_databricks_workspace.myworkspace.managed_resource_group_name
}

# Network Security Group Output
output "nsg_id" {
  description = "The ID of the Network Security Group"
  value       = module.network.nsg_id
}

# Sensitive Outputs (use with caution)
output "databricks_host_secret_name" {
  description = "The name of the Key Vault secret containing the Databricks host URL"
  value       = azurerm_key_vault_secret.databricks_host[0].name
  sensitive   = true
}

output "databricks_token_secret_name" {
  description = "The name of the Key Vault secret containing the Databricks access token"
  value       = azurerm_key_vault_secret.databricks_token[0].name
  sensitive   = true
}