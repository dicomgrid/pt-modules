variable "name" {default = "null"}
variable "description" {default = "null"}

variable "tags" {
  type        = map(string)
  description = "Resource Group Tags"
  default = {
    "Environment" = "",
    "Product"    = "",
    "Patch_Group"  = ""
  }
}
####
