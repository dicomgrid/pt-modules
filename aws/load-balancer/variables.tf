# Tags
variable "application" {
  default = ""
}
variable "billing" {}
variable "creator" {
  default = "Terraform"
}
variable "environment" {}
variable "name" {}
variable "owner" {
  default = "Platform"
}

# LB Variables
variable "enable_cross_zone_load_balancing" {
  default = true
}
variable "enable_deletion_protection" {
  default = false
}
variable "environment" {}
variable "internal" {}
variable "security_groups" {
  default = null
}
variable "subnets" {}
variable "load_balancer_type" {}
variable "vpc" {}

# LB Target Group Variables
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
variable "target_port" {}
variable "target_protocol" {}