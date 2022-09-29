variable "max_concurrency" {
  type        = number
  description = "Max target concurrency run rate"
  default     = "10"
}

variable "max_errors" {
  type        = number
  description = "Max Errors before halting task run"
  default     = "2"
}

variable "win_evac_priority" {
  type        = number
  description = "Priority of job to run. Lower number means higher priority"
}

variable "win_evac_window_id" {
  type        = string
  description = "Maintenance window of job"
}

variable "win_evac_window_target_id" {
  type        = string
  description = "Maintenance window of job"
}

variable "win_evac_name" {
  type = string
}

variable "service_role_arn" {
  type        = string
  description = "IAM Role to run step with"
  default     = "arn:aws:iam::601722232065:role/SSMServiceRole"
}
variable "task_type" {
  type        = string
  description = "Task Type to run (RUN_COMMAND or AUTOMATION)"
  default     = "RUN_COMMAND"
}

variable "cutoff_behavior" {
  type        = string
  description = "What to do when end of maintenance window is hit (CONTINUE_TASK or CANCEL_TASK)"
  default     = "CANCEL_TASK"
}

variable "output_s3_bucket" {
  type        = string
  description = "S3 bucket to deposit run job logs in"
  default     = null
}

variable "output_s3_prefix_key" {
  type        = string
  description = "S3 bucket to deposit run job logs in"
  default     = null
}

variable "timeout_seconds" {
  type        = number
  description = "Seconds before step times out"
  default     = "600"
}

variable "notification_arn" {
  type        = string
  description = "ARN of SNS notification subscription"
  default     = "arn:aws:sns:us-east-2:601722232065:sre-inf-aws-slack"
}

variable "notification_events" {
  type    = list(any)
  default = ["TimedOut", "Cancelled", "Failed"]
}