variable "attributes" {
  default = [
    {
      name = "LockID"
      type = "S"
    }
  ]
}
variable "billing_mode" { default = "PAY_PER_REQUEST" }
variable "hash_key" { default = "LockID" }
variable "name" { default = "terraform-state" }
variable "range_key" { default = null }
variable "read_capacity" { default = null }
variable "tags" {}
variable "write_capacity" { default = null }
