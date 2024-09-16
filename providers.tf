# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

provider "random" {
}

provider "databricks" {
  # host                        = azurerm_databricks_workspace.myworkspace.workspace_url
  alias                       = "workspace"
  azure_workspace_resource_id = azurerm_databricks_workspace.myworkspace.id
  azure_client_id             = var.azure_client_id
  azure_client_secret         = var.azure_client_secret
  azure_tenant_id             = var.azure_tenant_id
  host                        = data.azurerm_key_vault_secret.databricks_host.value  # for kv
  token                       = data.azurerm_key_vault_secret.databricks_token.value # for kv
}

## For KV ###
data "azurerm_key_vault_secret" "databricks_host" {
<<<<<<< HEAD
  #name         = "databricks-host"
  name         = azurerm_databricks_workspace.myworkspace.workspace_url
=======
  name         = "databricks-host"
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
  key_vault_id = azurerm_key_vault.key.id
}

data "azurerm_key_vault_secret" "databricks_token" {
<<<<<<< HEAD
  name         = "databricks-token-${azurerm_databricks_workspace.myworkspace.name}"
=======
  name         = "databricks-token"
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
  key_vault_id = azurerm_key_vault.key.id
}