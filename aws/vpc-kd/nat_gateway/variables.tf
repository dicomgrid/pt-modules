variable "subnet_id" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "allocation_id" {
  type    = string
  default = ""
}

variable "connectivity_type" {
  type    = string
  default = ""
}

variable "private_ip" {
  type    = string
  default = ""
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Automation"
    OWNER     = "Automation"
    OWNER2    = "Automation"
  }
}
