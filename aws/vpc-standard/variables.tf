
variable "Environment" { 
	default = "Production"
	type = string 
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