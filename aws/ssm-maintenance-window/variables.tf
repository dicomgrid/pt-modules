variable "cutoff" { default = 1 }
variable "duration" { default = 2 }
variable "schedule" { default = "" }
variable "schedule_timezone" { default = "America/New_York" }
variable "window_enabled" { default = false }
variable "window_name" { default = "" }
variable "tags" {
  type        = map(string)
  description = "Maintenance Window Tags"
  default = {
    "client_code" = ""
  }
}