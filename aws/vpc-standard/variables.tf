
variable "Environment" { 
	default = "Production"
	type = string 
}
variable "vpc_range" {
	type=string
	default = "10.137.0.0/22"
}

variable "Creator" {
	default = "Terraform"
	type = string 
}
variable "Billing" {
    default = ""
	type = string 
}
variable "tenancy" {
	default = "default"
	type = string 
}
variable "public_ip_on_launch" {
    type=bool
    default = true 
}
variable "dns_hostnames" {
	default = true
	type=bool 
}
variable "dns_support" {
	default = true
	type = bool 
}

variable "Owner" {
  default = "Platform"
  type = string
}