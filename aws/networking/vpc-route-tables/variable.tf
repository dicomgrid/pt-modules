variable "region" {
  description = "The region to use for AWS"
  type        = string
 
}

variable "vpc_id" {
  description = "The VPC ID where the route table will be created"
  type        = string
}

variable "route_table_name" {
  description = "Name for the route table"
  type        = string
}

variable "routes" {
  description = "List of routes to add to the route table"
  type        = list(object({
    cidr_block = string
    gateway_id = string
    gateway_type = string
  }))
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the route table"
  type        = list(string)
}
variable "environment" {
  description = "dev/staging/prod"
  type        = string
}

variable "code_managed" {
  description = "terraform"
}


# Tags


