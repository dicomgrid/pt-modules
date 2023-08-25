variable "domain_name" {
  type    = string
  default = ""
}
variable "domain_name_servers" {
  type    = list(any)
  default = []
}
variable "ntp_servers" {
  type    = list(any)
  default = []
}
variable "netbios_name_servers" {
  type    = list(any)
  default = []
}
variable "netbios_node_type" {
  type    = number
  default = null
}
variable "tags" {
  type = any
}