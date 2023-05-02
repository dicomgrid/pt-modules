variable "enable_cross_zone_load_balancing" {
  default = true
}
variable "enable_deletion_protection" {
  default = false
}

variable "health_check" {
  default = [
    {
      healthy_threshold   = null
      interval            = null
      matcher             = null
      path                = null
      port                = null
      timeout             = null
      unhealthy_threshold = null
    }
  ]
}
/*
variable "health_check" {
  default = []
  type = list(object({
    healthy_threshold   = number
    interval            = number
    matcher             = string
    path                = string
    port                = number
    timeout             = number
    unhealthy_threshold = number
  }))
}

variable "ebs_block_device" {
  default = [
    {
      delete_on_termination = null
      device_name           = null
      encrypted             = null
      volume_size           = null
      volume_type           = null
      iops                  = null
      throughput            = null
    }
  ]
}
*/
variable "internal" {}
variable "listener_action_type" {}
variable "listener_port" {}
variable "listener_protocol" {}
variable "load_balancer_type" {}
variable "security_groups" {
  default = null
}
variable "subnets" {}
variable "target_instances" {}
variable "target_port" {}
variable "target_protocol" {}
variable "vpc" {}


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