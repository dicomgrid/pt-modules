variable "name" {
  type        = string
  description = "name of patch baseline"
  default     = ""
}

variable "description" {
  type        = string
  description = "Description of patch baseline"
  default     = ""
}

variable "rejected_patches" {
  type    = list(string) #Example syntax: ["systemd", "corosync"]
  default = []
}

variable "centos_patch_classifications" {
  type = list(string)
  default = ["Security", "Bugfix", "Recommended"]
}