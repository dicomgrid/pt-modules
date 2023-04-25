variable "allow_validation_record_overwrite" {
  default = true
}
variable "domain_name" {}
variable "subject_alternative_names" {
  default = []
  type    = list(string)
}
variable "tags" {}
variable "validation_record_ttl" {
  default = 60
  type    = number
}
variable "validation_method" {
  default = "DNS"
}

variable "wildcard" {
  default = false
}
