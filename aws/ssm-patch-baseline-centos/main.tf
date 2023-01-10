resource "aws_ssm_patch_baseline" "pb-linux" {
  name             = var.name
  description      = var.description
  operating_system = "CENTOS"
  rejected_patches = [jsonencode(var.rejected_patches)]

  global_filter {
    key = "CLASSIFICATION"
    values = var.centos_patch_classifications
  }

  approval_rule {
    approve_after_days = var.approval_day_count
    enable_non_security = true
    compliance_level = "CRITICAL"

    patch_filter {
      key = "CLASSIFICATION"
      values = var.centos_patch_classifications
    }
    patch_filter {
      key = "SEVERITY"
      values = ["Critical", "Important"]
    }
  }

  approval_rule {
    approve_after_days = var.approval_day_count
    enable_non_security = true
    compliance_level = "MEDIUM"

    patch_filter {
      key = "CLASSIFICATION"
      values = var.centos_patch_classifications
    }
    patch_filter {
      key = "SEVERITY"
      values = ["Moderate"]
    }
  }

  approval_rule {
    approve_after_days = var.approval_day_count
    enable_non_security = true
    compliance_level = "LOW"

    patch_filter {
      key = "CLASSIFICATION"
      values = var.centos_patch_classifications
    }
    patch_filter {
      key = "SEVERITY"
      values = ["Low"]
    }
  }

}