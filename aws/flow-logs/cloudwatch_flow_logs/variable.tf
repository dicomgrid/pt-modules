variable "account_id" {}

variable "region" {}

variable "vpc_id" {}


variable "log_destination" {}
variable "traffic_type" {}

variable "max_aggregation_interval" {}

variable "LogDeliveryEnabled" {
  type    = bool
  default = true
}
variable "log_source" {
  type    = string
  default = "vpc"
}
variable "codemanaged" {
  type    = string
  default = "Terraform"

}
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
variable "iam_role_arn" {}

variable "enable_subnet_logs" {
  type    = bool
  default = false
}
variable "enable_vpc_logs" {
  type    = bool
  default = false
}
variable "enable_eni_logs" {
  type    = bool
  default = false
}


variable "enable_tgw_attachment_logs" {
  type    = bool
  default = false
}
