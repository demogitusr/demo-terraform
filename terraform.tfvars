# dbfs_prefix           = "dbfs"
cidr                  = "10.0.0.0/20"
azure_client_id       = "5ee68e82-9124-4b8b-a3f8-63f5d211ae22"
azure_client_secret   = "jIM8Q~8qlbuMcutKqe~rg6tmuVMlBSeBwYztcbwn"
azure_tenant_id       = "29da77b8-c32f-4c14-9a02-e7bd026dd69f"
azure_subscription_id = "b35f9dfe-a181-45df-8aa3-c5ca1482d68b"
create_duration       = "240s"
environment           = "dev"
rglocation            = "uksouth"


## KV value ##
sku_name = "standard"

tags = {
  Project     = "Databricks-Demo"
  Environment = "Development"
  ManagedBy   = "Terraform"
}

### multi workspace ##
additional_workspace_count = "0"
databricks_sku             = "premium"