resource "aws_ssm_maintenance_window" "maintenance_window" {
  name              = var.window_name
  enabled = var.window_enabled
  schedule          = var.schedule
  schedule_timezone = var.schedule_timezone
  duration          = var.duration
  cutoff            = var.cutoff
}