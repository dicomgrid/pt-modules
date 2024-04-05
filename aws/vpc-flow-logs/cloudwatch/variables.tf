variable "account_id" {}

variable "region" {}

variable "vpc_id" {}


variable "log_destination" {}
variable "traffic_type" {}

variable "max_aggregation_interval" {}

variable "retention_in_days" {
  type    = number
  default = 180
}
variable "log_destination_type" {
  type    = string
  default = "cloud-watch-logs"
}
variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
variable "iam_role_arn" {
  type = string
}

variable "enable-subnet-logs" {

}
variable "enable-vpc-logs" {

}
variable "enable-eni-logs" {

}

variable "enable-tgw-attachment-logs" {

}
