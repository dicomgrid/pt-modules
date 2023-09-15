resource "aws_ssm_patch_baseline" "windows_pb" {
  name             = var.name
  description      = var.description
  operating_system = "WINDOWS"
  approved_patches = try(var.approved_patches, false)
  rejected_patches = try(var.rejected_patches, false)

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
    approve_after_days = var.approval_day_count
    approve_until_date = var.approve_until_date
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
    approve_after_days = var.approval_day_count
    approve_until_date = var.approve_until_date
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
    approve_after_days = var.approval_day_count
    approve_until_date = var.approve_until_date
    compliance_level   = "LOW"

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