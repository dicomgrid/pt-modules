resource "aws_ssm_patch_baseline" "pb-linux" {
  name             = var.name
  description      = var.description
  operating_system = "CENTOS"
  rejected_patches = [jsonencode(var.rejected_patches)]

  global_filter {
    key = "CLASSIFICATION"
    values = [
      "Security",
      "Bugfix",
      "Recommended"
    ]
  }

  approval_rule {
    approve_after_days = 7
    compliance_level = "CRITICAL"
    patch_filter {
      key = "CLASSIFICATION"
      values = var.centos_patch_classifications
    }
    patch_filter {
      key = "SEVERITY"
      values = ["Critical"]
    }
    #TODO: Add Medium Severity Level
    #TODO: Add Low Severity Level
  }

}