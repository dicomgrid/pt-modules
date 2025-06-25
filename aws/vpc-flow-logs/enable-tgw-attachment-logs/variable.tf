
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
variable "vpc_id" {}
variable "transit_gateway_id" { type = string }
