variable "aws_account_id" {
  type        = string
  description = "AWS Account ID for the resource owner"
}

variable "global_network_id" {
  type        = string
  description = "Identifier for the global network in AWS Network Manager"
}

variable "transit_gateways" {
  type        = list(string)
  description = "List of transit gateway identifiers for registration"
}
variable "region" {
  type = string
}

