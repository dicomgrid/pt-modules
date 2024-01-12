variable "access_logs" { default = {} }
variable "connection_logs" { default = {} }
variable "customer_owned_ipv4_pool" { default = null }
variable "desync_mitigation_mode" { default = null }
variable "dns_record_client_routing_policy" { default = null }
variable "drop_invalid_header_fields" { default = null }
variable "enable_cross_zone_load_balancing" { default = true }
variable "enable_deletion_protection" { default = false }
variable "enable_http2" { default = null }
variable "enable_tls_version_and_cipher_suite_headers" { default = null }
variable "enable_waf_fail_open" { default = null }
variable "enable_xff_client_port" { default = null }
variable "enforce_security_group_inbound_rules_on_private_link_traffic" { default = null }
variable "idle_timeout" { default = null }
variable "internal" {}
variable "ip_address_type" { default = null }
variable "listeners" { default = {} }
variable "load_balancer_type" {}
variable "name_prefix" { default = null }
variable "name" {}
variable "preserve_host_header" { default = null }
variable "security_groups" { default = null }
variable "subnet_mapping" { default = [] }
variable "subnets" {}
variable "target_group_attachments" { default = {} }
variable "target_groups" { default = {} }
variable "timeouts" { default = {} }
variable "vpc" {}
variable "xff_header_processing_mode" { default = null }

# Tags
locals {
  default_tags = {
    CodeManaged              = var.code_managed
    Compliance               = var.compliance
    Name                     = var.name
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
