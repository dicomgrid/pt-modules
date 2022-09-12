variable "domain_name" {
  default = "pt.intelerad.com"
  type    = string
}
variable "subject_alternative_names" {
  default = []
  type    = list(string)
}
variable "validation_record_ttl" {
  default = 60
  type    = number
}
variable "allow_validation_record_overwrite" {
  default = true
}
variable "validation_method" {
  default = "DNS"
}