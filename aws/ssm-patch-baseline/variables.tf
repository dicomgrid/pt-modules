variable "name" {default = "null"}
variable "patch_classifications" {default = ["Security", "Bugfix", "Recommended"]}
variable "description" { default = "null" }
variable "rejected_patches" { default = null }
variable "approved_patches" { default = null }
variable "operating_system" { default = "null" }
variable "approval_days" { default = 7 }
variable "enable_non_security" {default = true}
variable "compliance_levels" {
  type = list(object({
    
    compliance_level = string
    severity = list(string)
  }))

  default = [
      {
      compliance_level = "CRITICAL"
      severity = ["Critical", "Important"]
      },
      {
      compliance_level = "MEDIUM"
      severity = ["Moderate"]
      },
      {
      compliance_level = "LOW"
      severity = ["Low"]
      },
  ]
}
