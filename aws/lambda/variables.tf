variable "architectures" {}
variable "function_code" {}
variable "function_name" {}
variable "handler" {}
variable "source_code_filename" {}
variable "environment_variables" {}
variable "role" {}
variable "timeout" { default = 3 }
variable "runtime" { default = "" }