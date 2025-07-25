resource "aws_ssm_maintenance_window_task" "ssm-shell-task" {
  name             = var.shell_task_name
  window_id        = var.shell_task_window_id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunShellScript"
  priority         = var.shell_task_priority
  service_role_arn = var.service_role_arn
  max_concurrency  = var.max_concurrency
  max_errors       = var.max_errors
  targets {
    key    = "WindowTargetIds"
    values = [var.shell_task_window_target_id]
  }
  task_invocation_parameters {
    run_command_parameters {
      service_role_arn     = var.service_role_arn
      timeout_seconds      = var.timeout_seconds
      parameter {
        name = "commands"
        values = ["${file("${path.module}/../ssm-tools/scripts/${var.shell_task}")}"]
      }
    }
  }
}