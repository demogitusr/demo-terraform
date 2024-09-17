data "azurerm_client_config" "current" {}

<<<<<<< HEAD
resource "null_resource" "validate_tenant_id" {
  count = var.azure_tenant_id == data.azurerm_client_config.current.tenant_id ? 0 : 1
  lifecycle {
    precondition {
      condition     = var.azure_tenant_id == data.azurerm_client_config.current.tenant_id
      error_message = "Specified azure_tenant_id does not match current context."
    }
  }
}

=======
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
resource "azurerm_key_vault" "key" {
  name                        = "kv-databricks-${var.environment}-${random_string.suffix.result}"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  enabled_for_disk_encryption = true
<<<<<<< HEAD
  tenant_id                   = var.azure_tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  sku_name                    = var.sku_name

  access_policy {
    tenant_id = var.azure_tenant_id
=======
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = var.sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create", "Delete",
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete",
    ]
  }

  tags = var.tags
}

resource "azurerm_key_vault_secret" "databricks_host" {
<<<<<<< HEAD
  count = var.additional_workspace_count + 1
  # name         = "databricks-host"
  # value        = azurerm_databricks_workspace.myworkspace.workspace_url
  name         = "databricks-host-${count.index == 0 ? "main" : count.index}"
  value        = count.index == 0 ? azurerm_databricks_workspace.myworkspace.workspace_url : azurerm_databricks_workspace.additional_workspaces[count.index - 1].workspace_url
  key_vault_id = azurerm_key_vault.key.id
  depends_on   = [azurerm_databricks_workspace.myworkspace, azurerm_databricks_workspace.additional_workspaces]
}

resource "azurerm_key_vault_secret" "databricks_token" {
  count = var.additional_workspace_count + 1
  # name         = "databricks-token-${count.index}"
  name         = count.index == 0 ? "databricks-token-${azurerm_databricks_workspace.myworkspace.name}" : "databricks-token-${azurerm_databricks_workspace.additional_workspaces[count.index - 1].name}"
  value        = databricks_token.pat[count.index].token_value
  key_vault_id = azurerm_key_vault.key.id
  depends_on   = [databricks_token.pat]

  lifecycle {
    create_before_destroy = true
  }
=======
  name         = "databricks-host"
  value        = azurerm_databricks_workspace.myworkspace.workspace_url
  key_vault_id = azurerm_key_vault.key.id
}

resource "azurerm_key_vault_secret" "databricks_token" {
  count        = var.additional_workspace_count + 1
  name         = "databricks-token-${count.index}"
  value        = databricks_token.pat[count.index].token_value
  key_vault_id = azurerm_key_vault.key.id
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}