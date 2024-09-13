data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key" {
  name                        = "kv-databricks-${var.environment}-${random_string.suffix.result}"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = var.sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
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
  name         = "databricks-host"
  value        = azurerm_databricks_workspace.myworkspace.workspace_url
  key_vault_id = azurerm_key_vault.key.id
}

resource "azurerm_key_vault_secret" "databricks_token" {
  count        = var.additional_workspace_count + 1
  name         = "databricks-token-${count.index}"
  value        = databricks_token.pat[count.index].token_value
  key_vault_id = azurerm_key_vault.key.id
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}