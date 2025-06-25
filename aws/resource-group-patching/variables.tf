variable "tags" {
  type        = map(string)
  description = "Resource Group Tags"
  default = {
    "client_code"   = "",
    "Platform Type" = ""
  }
}

variable "resource_group" {}

