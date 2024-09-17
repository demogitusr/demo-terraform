variable "autotermination_minutes" {
  type    = number
  default = 60
}
variable "spark_version" {
  type = string
  default     =  "14.3.x-scala2.12"
}

variable "node_type_id" {
  type = string
  default     = "Standard_DS3_v2"
}

