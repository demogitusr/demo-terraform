<<<<<<< HEAD
=======
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">=1.21.0"
    }
  }
}
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197

resource "random_string" "naming" {
  special = false
  upper   = false
<<<<<<< HEAD
  length  = 6
=======
  length  = 4
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
}

resource "azurerm_resource_group" "this" {
  name     = "${random_string.naming.result}-rg"
  location = var.rglocation
  tags     = local.tags
}

locals {
  prefix          = join("-", [var.workspace_prefix, "${random_string.naming.result}"])
  location        = var.rglocation
  dbfsname        = join("", [var.dbfs_prefix, "${random_string.naming.result}"]) // dbfs name must not have special chars
  workspace_names = [for i in range(var.additional_workspace_count) : "${local.prefix}-workspace-${i + 2}"]
  // tags that are propagated down to all resources
  tags = merge({
    Environment = "Testing"
    Epoch       = random_string.naming.result
  }, var.tags)
}

# resource "azurerm_databricks_workspace" "additional_workspaces" {
#   count = var.additional_workspace_count
#   name  = "${local.prefix}-workspace-${count.index + 2}"
#   resource_group_name = azurerm_resource_group.this.name
#   location            = azurerm_resource_group.this.location
#   sku                 = var.databricks_sku
#   tags                = local.tags
# }
data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  depends_on        = [azurerm_databricks_workspace.myworkspace, time_sleep.wait_duration]
}

data "databricks_node_type" "smallest" {
  local_disk = true
  depends_on = [azurerm_databricks_workspace.myworkspace, time_sleep.wait_duration]
}

resource "time_sleep" "wait_duration" {
  depends_on      = [azurerm_databricks_workspace.myworkspace]
  create_duration = var.create_duration
}

resource "databricks_token" "pat" {
  # comment          = "Terraform Automation"
  # lifetime_seconds = 7776000 // 90 days
  count            = var.additional_workspace_count + 1 // +1 for the main workspace
  provider         = databricks.workspace
  comment          = "Terraform Automation for Workspace ${count.index == 0 ? "Main" : count.index}"
  lifetime_seconds = 7776000 // 90 days
<<<<<<< HEAD
}


##Call module network
module "network" {
  source              = "./modules/network"
  prefix              = var.prefix
  rglocation          = var.rglocation
  resource_group_name = azurerm_resource_group.this.name
  vnet_cidr           = var.cidr
  tags                = var.tags
=======
>>>>>>> 49c1599a9fe7303faee4d2e9a696ea7bd402d197
}