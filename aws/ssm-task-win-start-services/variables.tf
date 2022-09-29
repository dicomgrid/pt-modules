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

variable "win_start_services_priority" {
  type        = number
  description = "Priority of job to run. Lower number means higher priority"
}

variable "win_start_services_window_id" {
  type        = string
  description = "Maintenance window of job"
}

variable "win_start_services_window_target_id" {
  type        = string
  description = "Maintenance window of job"
}

variable "win_start_services_name" {
  type = string
}

variable "task_type" {
  type        = string
  description = "Task Type to run (RUN_COMMAND or AUTOMATION)"
  default     = "RUN_COMMAND"
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

variable "service_role_arn" {
  type        = string
  description = "IAM Role to run step with"
  default     = "arn:aws:iam::601722232065:role/SSMServiceRole"
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