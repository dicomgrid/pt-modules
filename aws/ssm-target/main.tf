resource "aws_ssm_maintenance_window_target" "maintenance_window_target" {
  window_id   = var.window_id
  name        = var.name
  description = var.description
  #TODO: Add support for tag queries https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_target#instance-target
  resource_type = "RESOURCE_GROUP"
  targets {
    key    = "resource-groups:Name"
    values = [var.name]
  }
}