locals {
  # Get account info from data block
  ou = data.aws_organizations_organizational_units.main.children[*]
  # Create a map of child OU names and IDs from the accounts variable
  ou_map = { for ou in local.ou : ou.name => ou.id }

}



# Input Variables
variable "name" {}
variable "content" {}
variable "description" {}
variable "type" {
  default = "SERVICE_CONTROL_POLICY"
}

variable "ou_name" {}