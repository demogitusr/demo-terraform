## Create single workspce ##
resource "azurerm_databricks_workspace" "myworkspace" {
  name                = "adb-${random_string.suffix.result}-workspace-1"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = var.databricks_sku
  # tags                = local.tags
  managed_resource_group_name = "databricks-rg-${random_string.suffix.result}"

  custom_parameters {
    no_public_ip                                         = var.no_public_ip
    virtual_network_id                                   = module.network.vnet_id
    private_subnet_name                                  = module.network.private_subnet_name
    public_subnet_name                                   = module.network.public_subnet_name
    public_subnet_network_security_group_association_id  = module.network.public_subnet_nsg_association_id
    private_subnet_network_security_group_association_id = module.network.private_subnet_nsg_association_id
    storage_account_name                                 = local.dbfsname

  }
  # We need this, otherwise destroy doesn't cleanup things correctly
  # depends_on = [
  #   azurerm_subnet_network_security_group_association.public,
  #   azurerm_subnet_network_security_group_association.private
  # ]
}
## Additional when need multi workspace ##
resource "azurerm_databricks_workspace" "additional_workspaces" {
  count               = var.additional_workspace_count
  name                = "adb-${random_string.suffix.result}-workspace-${count.index + 2}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = var.databricks_sku
  # tags                = local.tags
  managed_resource_group_name = "databricks-rg-${random_string.suffix.result}-${count.index + 2}"

  custom_parameters {
    no_public_ip = var.no_public_ip
    # virtual_network_id                                   = azurerm_virtual_network.this.id
    # private_subnet_name                                  = azurerm_subnet.private.name
    # public_subnet_name                                   = azurerm_subnet.public.name
    virtual_network_id                                   = module.network.vnet_id
    private_subnet_name                                  = module.network.private_subnet_name
    public_subnet_name                                   = module.network.public_subnet_name
    public_subnet_network_security_group_association_id  = module.network.public_subnet_nsg_association_id
    private_subnet_network_security_group_association_id = module.network.private_subnet_nsg_association_id
    storage_account_name                                 = local.dbfsname
  }
  # We need this, otherwise destroy doesn't cleanup things correctly
  # depends_on = [
  #   azurerm_subnet_network_security_group_association.public,
  #   azurerm_subnet_network_security_group_association.private
  # ]
}

module "auto_scaling_cluster_example" {
  source                  = "./modules/autoscaling_cluster"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = var.node_type
  autotermination_minutes = var.global_auto_termination_minute
}

## Single cluster  ##

# module "single_cluster" {
#   source = "./modules/single_cluster"
#   spark_version = data.databricks_spark_version
#   node_type_id            = var.node_type
#   autotermination_minutes = var.global_auto_termination_minute
# }
