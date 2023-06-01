variable "tgw_id" {
  description = "The tgw id of the tgw that is to be shared"
}

variable "resource_share_name" {
  description = "Name of share to easily identify"
}
variable "default_tags" {
  description = "Default tags to be applied to all resources"
  type        = map(string)
  default = {

  }
}
variable "account_ids" {
  description = "The AWS Account ID numbers of the accounts with which you are sharing your subnet"
  type        = list(string)
}
