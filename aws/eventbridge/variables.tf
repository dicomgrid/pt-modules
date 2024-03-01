variable "lambda_arn" { type = string }
variable "eventbus_name" { default = null }
variable "rule_name" { type = string }
variable "event_pattern" { default = "" }
variable "tags" { default = null }
