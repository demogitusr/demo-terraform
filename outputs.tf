output "databricks_azure_workspace_resource_id" {
  value = azurerm_databricks_workspace.myworkspace.id
}

output "workspace_url" {
  value = "https://${azurerm_databricks_workspace.myworkspace.workspace_url}/"
}

output "module_cluster_id" {
  value = module.auto_scaling_cluster_example.cluster_id
}

output "key_vault_name" {
  value = azurerm_key_vault.key.name
}

output "databricks_workspace_url" {
  value = azurerm_databricks_workspace.myworkspace.workspace_url
}

## Additional when need multi workspace ##
output "databrick_additional_workspace_urls" {
  value = {
    for i, workspace in azurerm_databricks_workspace.additional_workspaces :
    "workspace_${i + 2}" => workspace.workspace_url
  }
}

output "databrick_additional_workspace_ids" {
  value = {
    for i, workspace in azurerm_databricks_workspace.additional_workspaces :
    "workspace_${i + 2}" => workspace.id
  }
}