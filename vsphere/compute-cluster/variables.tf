variable "name" {}

variable "datacenter" {}

variable "hosts" {}

variable "drs_enabled" {
  default = true
}

variable "drs_automation_level" {
  default = "fullyAutomated"
}

variable "drs_migration_threshold" {
  default = 3
}

variable "ha_enabled" {
  default = true
}