resource "aws_ssm_maintenance_window_task" "task_patch_reboot_hooks" {
  name = var.patch_reboot_name
  window_id = var.patch_reboot_window_id
  task_type        = var.task_type
  #cutoff_behavior = var.cutoff_behavior
  task_arn         = "AWS-RunPatchBaselineWithHooks"
  priority         = var.patch_reboot_priority
  service_role_arn = var.service_role_arn
  max_concurrency  = var.max_concurrency
  max_errors       = var.max_errors
  targets {
    key    = "WindowTargetIds"
    values = [var.patch_reboot_window_target_id]
  }
  task_invocation_parameters {
    run_command_parameters {
      parameter {
      name   = "Operation"
      values = ["Install"]
      }

      parameter {
        name   = "RebootOption"
        values = ["NoReboot"]
      }
      
      parameter {
        name   = "PreInstallHookDocName"
        values = ["AWS-Noop"]
      }

      parameter {
        name   = "PostInstallHookDocName"
        values = ["AWS-Noop"]
      }

      output_s3_bucket     = var.output_s3_bucket
      output_s3_key_prefix = var.output_s3_prefix_key
      service_role_arn     = var.service_role_arn
      timeout_seconds      = "600"
      notification_config {
        notification_arn    = var.notification_arn
        notification_events = var.notification_events
        notification_type   = "Command"
      }
    }
  }
}