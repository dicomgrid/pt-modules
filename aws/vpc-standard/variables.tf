variable "region" {
  default = "us-west-1"
}

variable "environment" {
  description = "Deployment Environment"
  default ="development"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.138.0.0/23"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.138.1.0/26"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.138.0.0/26"]
}
