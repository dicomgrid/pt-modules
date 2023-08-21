


variable "iam_role_arn" {
  description = "IAM role ARN for CloudWatch logs"
}

variable "log_destination_type" {
  description = "Log destination type"
}

variable "log_destination" {
  description = "Log destination ARN"
}

variable "traffic_type" {
  description = "Traffic type to log"
}

variable "tags" {
  description = "Tags for the flow log"
  type        = map(string)
}
variable "max_aggregation_interval" {}
variable "enable_vpc_logs" {}
variable "vpc_id" {
}
