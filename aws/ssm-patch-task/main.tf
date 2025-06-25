resource "aws_ssm_maintenance_window_task" "ssm-patch-task" {
  name             = var.patch_task_name
  window_id        = var.patch_window_id
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaselineWithHooks"
  priority         = var.patch_task_priority
  service_role_arn = var.service_role_arn
  max_concurrency  = var.max_concurrency
  max_errors       = var.max_errors
  targets {
    key    = "WindowTargetIds"
    values = var.patch_window_target_id
  }
  task_invocation_parameters {
    run_command_parameters {
      service_role_arn = var.service_role_arn
      timeout_seconds  = var.timeout_seconds
      dynamic "parameter" {
        for_each = var.patch_tasks
        content {
          name   = parameter.value.name
          values = parameter.value.values
        }
      }
    }
  }
}