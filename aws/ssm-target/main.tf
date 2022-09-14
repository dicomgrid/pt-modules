resource "aws_ssm_maintenance_window_target" "maintenance_window_target" {
  window_id     = var.window_id
  name          = var.name
  description   = var.description
  resource_type = "RESOURCE_GROUP"
  targets {
    key    = "resource-groups:Name"
    values = [var.name]
  }
}