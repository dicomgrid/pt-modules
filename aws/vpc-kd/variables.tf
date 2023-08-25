variable "tags" {
  type = map(any)
  default = {
    Owner                    = "IT"
    Product                  = "Network"
    Enviroment               = "prod"
    Billing                  = "IT"
    OneTime                  = null
    aws-migration-project-id = "MPE24884"
    map-migrated             = "d-server-01d6zedrzy7814"
  }
}

# variable "vpc-details" {
#   type = object({
#     vpc_name       = string
#     vpc_cidr_block = string
#     # vpc_subnets = list(object({
#     #   subnet_name             = string
#     #   subnet_cidr_block       = string
#     #   availability_zone       = string
#     #   map_public_ip_on_launch = string
#     #   nat_gateway             = string
#     # }))
#     vpc_subnets  = any
#     aws_accounts = any
#     # vpc_security_group = list(object({
#     #   sg_name        = string
#     #   sg_description = string
#     #   port           = list(number)
#     # }))
#   })
#   default = {
#     vpc_name       = ""
#     vpc_cidr_block = ""
#     vpc_subnets = [{
#       subnet_name             = ""
#       subnet_cidr_block       = ""
#       availability_zone       = ""
#       map_public_ip_on_launch = ""
#       nat_gateway             = "false"
#     }]
#     aws_accounts = {}
#     # vpc_security_group = [{
#     #   sg_name        = ""
#     #   sg_description = ""
#     #   port           = [22]
#     # }]
#   }
# }


variable "vpc-details" {
  type = any
}
# variable "aws_cli_profile" {
#   type = string
# }
# variable "aws_cli_region" {
#   type = string
# }

variable "dhcp-options-set-ids" {
  type = any
}

