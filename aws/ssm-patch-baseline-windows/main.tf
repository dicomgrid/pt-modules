resource "aws_ssm_patch_baseline" "windows_pb" {
  name             = var.name
  description      = var.description
  operating_system = "WINDOWS"
  approved_patches = var.windows_approved_patches
  rejected_patches = var.windows_rejected_patches

#Default rule and classifications, tuned towards critical and security updates
  global_filter {
    key    = "PRODUCT"
    values = var.windows_patch_product
  }

  global_filter {
    key    = "CLASSIFICATION"
    values = var.windows_patch_classification
  }

  global_filter {
    key    = "MSRC_SEVERITY"
    values = ["Critical", "Important", "Moderate", "Low", "Unspecified"]
  }

#Medium Compliance Patch Filter
  approval_rule {
    approve_after_days = 7
    compliance_level   = "CRITICAL"

    patch_filter {
      key    = "PRODUCT"
      values = var.windows_patch_product
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = var.windows_patch_classification
    }

    patch_filter {
      key    = "MSRC_SEVERITY"
      values = ["Critical", "Important"]
    }
  }

  approval_rule {
    approve_after_days = 7
    compliance_level   = "MEDIUM"

    patch_filter {
      key    = "PRODUCT"
      values = var.windows_patch_product
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = var.windows_patch_classification
    }

    patch_filter {
      key    = "MSRC_SEVERITY"
      values = ["Moderate"]
    }
  }

#Low Compliance Patch Filter
  approval_rule {
    approve_after_days = 7
    compliance_level = "LOW"

    patch_filter {
      key    = "PRODUCT"
      values = var.windows_patch_product
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = var.windows_patch_classification
    }

    patch_filter {
      key    = "MSRC_SEVERITY"
      values = ["Low"]
    }
  }
}