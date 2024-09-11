## Create resource group and Workspace ##
resource "azurerm_resource_group" "resourcegroup" {
location = var.location
name = var.resource_group_name
}

resource "azurerm_databricks_workspace" "workspace" {
location = azurerm_resource_group.resourcegroup.location
name = var.databricks_workspace_name
resource_group_name = azurerm_resource_group.resourcegroup.name
sku = var.databricks_sku
}

## Create Databrick Cluster ##

data "databricks_node_type" "smallest" {
depends_on = [ azurerm_databricks_workspace.workspace ]   ## Depend on worksapce
local_disk = true
}

data "databricks_spark_version" "latest_lts" {
depends_on = [ azurerm_databricks_workspace.workspace ]
long_term_support = true
}

## Create instance pool ##
resource "databricks_instance_pool" "pool" {
instance_pool_name = "CodeRedPool"
min_idle_instances = 0
max_capacity = 10
# node_type_id = databricks_node_type.smallest.id
node_type_id = "Standard_DS3_v2"

idle_instance_autotermination_minutes = 10   ## setting for when not working will terminate
}


## Create Databrick cluster ##
resource "databricks_cluster" "shared_autoscaling" {
depends_on = [ azurerm_databricks_workspace.workspace ]
instance_pool_id = databricks_instance_pool.pool
cluster_name            = "Shared Autoscaling"
spark_version           = data.databricks_spark_version.latest_lts.id
node_type_id            = data.databricks_node_type.smallest.id
autotermination_minutes = 20
autoscale {
    min_workers = 1
    max_workers = 50
}
spark_conf = {
"spark.databricks.io.cache.enabled" : true,
# "spark.databricks.io.cache.maxDiskUsage" : "50g",
# "spark.databricks.io.cache.maxMetaDataCache" : "1g"
}
custom_tags = {
    "createdby" = "Infrateam"
}


}