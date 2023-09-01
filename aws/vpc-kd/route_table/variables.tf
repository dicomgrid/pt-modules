variable "vpc_id" {
  type = string
}

variable "propagating_vgws" {
  type    = list(any)
  default = []
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Automation"
    OWNER     = "Automation"
    OWNER2    = "Automation"
  }
}
