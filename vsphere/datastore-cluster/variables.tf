variable "name" {}

variable "datacenter" {}

variable "sdrs_enabled" {
  default = true
}

variable "sdrs_automation_level" {
  default = "automated"
}

variable "sdrs_io_latency_threshold" {
  default = 40
}

variable "sdrs_space_utilization_threshold" {
  default = 80
}