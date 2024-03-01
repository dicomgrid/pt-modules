variable "architectures" {}
variable "archive_file" { default = "" }
variable "create_log_group" { default = true }
variable "environment_variables" {}
variable "function_code" {}
variable "function_name" {}
variable "handler" {}
variable "log_retention_in_days" {}
variable "role" {}
variable "runtime" { default = "" }
variable "tags" { default = null }
variable "timeout" { default = 3 }
variable "prevent_destroy_logs" {}
