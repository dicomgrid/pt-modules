## Target Vars ##

variable "description" {
  type        = string
  description = "Description of maintenance window target"
  default     = ""
}

variable "resource_type" {
  type        = string
  description = "Type of target. Example: RESOURCE_GROUP"
  default     = ""
}

variable "name" {
  type        = string
  description = "Name of Resource Group that contains maintenance window targets"
  default     = ""
}

variable "window_id" {
  type        = string
  description = "Maintenance Window ID to associate to targets"
  default     = ""
}