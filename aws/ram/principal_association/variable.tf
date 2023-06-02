variable "account_ids" {
  description = "The AWS Account ID numbers of the accounts with which you are sharing your subnet"
  type        = list(string)
}

variable "resource_share_arn" {
  description = "The ARN of the resource share"
  type        = string
}
