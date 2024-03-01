variable "architectures" {}
variable "archive_file" { default = "" }
variable "function_code" {}
variable "function_name" {}
variable "handler" {}
variable "environment_variables" {}
variable "role" {}
variable "timeout" { default = 3 }
variable "runtime" { default = "" }