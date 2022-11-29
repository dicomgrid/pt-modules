variable "application" {
  default = ""
}
variable "billing" {}
variable "creator" {
  default = "Terraform"
}
variable "enable_cross_zone_load_balancing" {
  default = true
}
variable "enable_deletion_protection" {
  default = false
}
variable "environment" {}

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
variable "name" {}
variable "owner" {
  default = "Platform"
}

variable "security_groups" {
  default = null
}
variable "subnets" {}
variable "target_instances" {}
variable "target_port" {}
variable "target_protocol" {}
variable "vpc" {}
