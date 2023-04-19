locals {
  tags_base = {
    Billing     = var.billing
    CodeManaged = var.code_managed
    Creator     = var.creator
    Environment = var.environment
    Name        = var.name
    Owner       = var.owner
  }
  tags = merge(local.tags_base, var.tags_extra)
}

variable "attributes" {
  default = [
    {
      name  = "LockID"
      value = "S"
    }
  ]
}
variable "billing_mode" { default = "PAY_PER_REQUEST" }
variable "hash_key" { default = "LockID" }
variable "name" { default = "terraform-state" }
variable "range_key" { default = null }
variable "read_capacity" { default = null }
variable "tags_extra" { default = {} }
variable "write_capacity" { default = null }
