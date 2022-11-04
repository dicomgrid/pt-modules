variable "email" {}
variable "first_name" {}
variable "groups" {}
variable "last_name" {}
variable "name" {}
variable "path" {}
variable "service_account" {}
variable "service_account_map" {
    type = map(any)
    default = {
        true = false
        false = true
    }
}
variable "tags" {
    type = map(string)
    default = {}
}
variable "user_type" {}