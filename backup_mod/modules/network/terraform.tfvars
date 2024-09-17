# terraform.tfvars

# prefix          = "myproject"
rglocation        = "uksouth"
vnet_cidr       = "10.0.0.0/20"
# databricks_token = "dapi1234567890abcdef"  # ควรใช้วิธีที่ปลอดภัยกว่านี้ในการจัดการ token
tags = {
  Project     = "Databricks-Demo"
  Environment = "Development"
  ManagedBy   = "Terraform"
}