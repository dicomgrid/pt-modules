## Window Vars ##

variable "window_name" {
  type        = string
  description = "name of maintenance window"
  default     = ""
}

variable "schedule_timezone" {
  type        = string
  description = "Timezone for schedule. Example: America/New_York"
  default     = "America/New_York"
}

variable "schedule" {
  type        = string
  description = "maintenance window schedule"
  default     = ""
}

variable "duration" {
  type        = number
  description = "hours of duration of maintenance window"
  default     = 2
}

variable "cutoff" {
  type        = number
  description = "hours before maintenance window end where tasks are not permitted to be started"
  default     = 1
}