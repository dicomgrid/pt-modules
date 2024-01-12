variable "attachments" { default = [{}] }
variable "connection_termination" { default = null }
variable "deregistration_delay" { default = null }
variable "health_check" { default = {} }
variable "ip_address_type" { default = null }
variable "lambda_multi_value_headers_enabled" { default = null }
variable "load_balancing_algorithm_type" { default = null }
variable "load_balancing_anomaly_mitigation" { default = null }
variable "load_balancing_cross_zone_enabled" { default = null }
variable "name_prefix" { default = null }
variable "name" {}
variable "port" {}
variable "preserve_client_ip" { default = null }
variable "protocol_version" { default = null }
variable "protocol" {}
variable "proxy_protocol_v2" { default = null }
variable "slow_start" { default = null }
variable "target_type" { default = "instance" }
variable "vpc_id" {}
variable "stickiness" { default = {} }
variable "target_failover" { default = {} }
variable "target_health_state" { default = {} }
variable "load_balancer_type" { default = null }


# Tags
locals {
  default_tags = {
    CodeManaged              = var.code_managed
    Compliance               = var.compliance
    OneTime                  = var.onetime
    aws-migration-project-id = var.aws_project_id
    map-migrated             = var.map_migrated
  }
  tags = merge(local.default_tags, var.tags)
}
variable "tags" {}

variable "aws_project_id" { default = "null" }
variable "code_managed" { default = "true" }
variable "compliance" { default = "null" }
variable "map_migrated" { default = "null" }
variable "onetime" { default = "null" }
