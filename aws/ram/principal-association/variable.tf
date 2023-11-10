variable "principal" {
  description = "The principal to associate with the resource share. AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN."
  type        = list(string)
}

variable "resource_share_arn" {
  description = "The ARN of the resource share"
  type        = string
}
