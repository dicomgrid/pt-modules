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

variable "windows_patch_product" {
  type    = list(string)
  default = ["WindowsServer2012R2", "WindowsServer2016", "WindowsServer2019", "WindowsServer2022", "MicrosoftDefenderAntivirus"]
}

variable "windows_patch_classification" {
  type    = list(string)
  default = ["CriticalUpdates", "DefinitionUpdates", "Drivers", "FeaturePacks", "SecurityUpdates", "ServicePacks", "Tools", "UpdateRollups", "Updates", "Upgrades"]
}

variable "approval_day_count" {
  default = 7
}

variable "windows_approved_patches" {
  type    = list(string)
  default = ["KB123456"]
}

variable "windows_rejected_patches" {
  type    = list(string)
  default = ["KB123456"]
}