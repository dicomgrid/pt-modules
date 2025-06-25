# Input Variables
# Define all input variables for the module

variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

# TODO: Add your variables here
