locals {
  runtime_map = {
    "python3.8"  = ["python3.8"]
    "python3.9"  = ["python3.9"]
    "python3.10" = ["python3.10"]
    "python3.11" = ["python3.11"]
    "python3.12" = ["python3.12"]
    "python" = [
      "python3.8",
      "python3.9",
      "python3.10",
      "python3.11",
      "python3.12",
    ]
  }
}
variable "s3_bucket" {
  description = "S3 bucket containing the Lambda zip file"
  default     = null
}

variable "s3_key" {
  description = "S3 key of the Lambda zip file"
  default     = null
}

variable "layer_s3_bucket" {
  description = "S3 bucket containing the Lambda layer zip file"
  default     = null
}

variable "layer_s3_key" {
  description = "S3 key of the Lambda layer zip file"
  default     = null
}

variable "architectures" {
  type        = list(string)
  description = "Instruction set architecture for Lambda function"
}

variable "archive_file" {
  description = "Path to the Lambda deployment package"
  default     = null
}

variable "create_log_group" {
  description = "Controls if CloudWatch Log Group should be created"
  default     = true
}

variable "environment_variables" {
  description = "Environment variables for Lambda function"
  type        = map(string)
  default     = {}
}

variable "function_code" {
  description = "Path to Lambda function code file"
  default     = null
}

variable "function_name" {
  description = "Name of the Lambda function"
}

variable "handler" {
  description = "Function entrypoint in the code"
  default     = null
}

variable "layer_name" {
  description = "Name of the Lambda layer"
  default     = null
}

variable "layer_runtime" {
  description = "Runtime for Lambda layer compatibility"
  default     = "python"
}

variable "log_retention_in_days" {
  description = "CloudWatch log retention in days"
  default     = 7
}

variable "role" {
  description = "IAM role ARN for Lambda function"
}

variable "runtime" {
  description = "Runtime identifier"
}

variable "trigger_statement_id" {
  description = "Statement ID for EventBridge permission"
  default     = null
}

variable "trigger_source_arn" {
  description = "ARN of the event source"
  default     = null
}

variable "trigger_principal" {
  description = "Principal for Lambda permission"
  default     = null
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

variable "timeout" {
  description = "Lambda timeout in seconds"
  default     = 3
}
