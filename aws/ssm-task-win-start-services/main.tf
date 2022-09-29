resource "aws_ssm_maintenance_window_task" "task-win-start-services" {
  name = var.win_start_services_name
  window_id = var.win_start_services_window_id
  task_type       = var.task_type
  task_arn        = "AWS-RunPowerShellScript"
  priority        = var.win_start_services_priority
  service_role_arn = var.service_role_arn
  max_concurrency = var.max_concurrency
  max_errors      = var.max_errors
  targets {
    key    = "WindowTargetIds"
    values = [var.win_start_services_window_target_id]
  }
  task_invocation_parameters {
    run_command_parameters {
        output_s3_bucket     = var.output_s3_bucket
        output_s3_key_prefix = var.output_s3_prefix_key
        service_role_arn     = var.service_role_arn
        timeout_seconds      = var.timeout_seconds
      notification_config {
        notification_arn    = var.notification_arn
        notification_events = var.notification_events
        notification_type   = "Command"
      }
    parameter {
    name   = "commands"
    values = ["${file("${path.module}/../ssm-tools/scripts/pt-windows-start-services.ps1")}"]
    }
    }
  }
}