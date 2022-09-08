
variable "domain" {
  type    = string
  default = "pt.intelerad.com"
}

variable "private_zone" {
  default = true
}

variable "allow_overwrite" {
  default = true
}

variable "ttl" {
  default = 60
}

variable "sans" {
type = list(string)
 default = null
 }
