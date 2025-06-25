variable "name" {
  type        = string
  description = "Resource Group Name"
  default     = ""
}

variable "description" {
  type        = string
  description = "Description of resource group"
  default     = ""

}

variable "tags" {
  type        = map(string)
  description = "Resource Group Tags"
  default = {
    "Customer" = "",
    "Group"    = "",
    "Product"  = ""
  }
}

variable "resource_query" { default = null }

