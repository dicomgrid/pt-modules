locals {
    runtime_map = {
        "python3.8" = ["python3.8"]
        "python3.9" = ["python3.9"]
        "python3.10" = ["python3.10"]
        "python3.11" = ["python3.11"]
        "python3.12" = ["python3.12"]
        "python" = [
            "python3.8",
            "python3.9",
            "python3.10",
            "python3.11",
            "python3.12",
        ]
    }
}

variable "architectures" {}
variable "archive_file" { default = "" }
variable "create_log_group" { default = true }
variable "environment_variables" {}
variable "function_code" {}
variable "function_name" {}
variable "handler" {}
variable "layer_name" {}
variable "log_retention_in_days" { default = 7 }
variable "role" {}
variable "runtime" { default = "" }
variable "tags" { default = null }
variable "timeout" { default = 3 }
