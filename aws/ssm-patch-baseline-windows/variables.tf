variable "approval_day_count" { default = 7 }
variable "approved_patches" { default = [] }
variable "approve_until_date" { default = null }
variable "name" { default = "" }
variable "description" { default = "" }
variable "rejected_patches" { default = [] }
variable "windows_patch_product" {
  type = list(string)
  default = ["WindowsServer2012R2",
    "WindowsServer2016",
    "WindowsServer2019",
    "WindowsServer2022",
    "MicrosoftDefenderAntivirus"
  ]
}

variable "windows_patch_classification" {
  type = list(string)
  default = ["CriticalUpdates",
    "DefinitionUpdates",
    "Drivers",
    "FeaturePacks",
    "SecurityUpdates",
    "ServicePacks",
    "Tools",
    "UpdateRollups",
    "Updates",
    "Upgrades"
  ]
}
