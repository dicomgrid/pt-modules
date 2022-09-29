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
variable "patch_scan_priority" {
  type        = number
  description = "Priority of job to run. Lower number means higher priority"
}


variable "patch_scan_window_id" {
  type        = string
  description = "Maintenance window ID to associate task with"
  default     = null
}

variable "patch_scan_window_target_id" {
  type        = string
  description = "Maintenance window ID to associate task with"
  default     = null
}

variable "patch_scan_name" {
  type    = string
  default = null
}

variable "service_role_arn" {
  type        = string
  description = "IAM Role to run step with"
  default     = "arn:aws:iam::959946720450:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
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

variable "s3_region" {
  type        = string
  description = "S3 region log bucket lives"
  default     = null
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