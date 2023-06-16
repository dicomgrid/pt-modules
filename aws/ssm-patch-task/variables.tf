variable "patch_task_name" {default = "null"}
variable "patch_window_id" {default = "null"}
variable "patch_task_priority" {default = "null"}
variable "service_role_arn" {default = "null"}
variable "max_concurrency" {default = "null"}
variable "max_errors" {default = "null"}
variable "patch_window_target_id" {default = "null"}
variable "timeout_seconds" {default = 600}

variable "patch_tasks" {
  type = list(object({
    name = string
    values = list(string)
  }))
  default = [
      {
      name = "Operation"
      values = ["Scan"]
      },
      {
      name = "RebootOption"
      values = ["NoReboot"]
      },
      {
      name = "PreInstallHookDocName"
      values = ["AWS-Noop"]
      },
      {
      name = "PostInstallHookDocName"
      values = ["AWS-Noop"]
      },
  ]
}
