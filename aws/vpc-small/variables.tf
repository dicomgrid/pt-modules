variable "environment" {
}

variable "vpc_cidr" {

}

variable "public_subnets_cidr" {
  type = list(any)

}

variable "private_subnets_cidr" {
  type = list(any)

}

variable "region" {

}

variable "availability_zones" {
  type = list(any)

}
