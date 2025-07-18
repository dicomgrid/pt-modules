resource "aws_ssm_patch_baseline" "linux_pb" {
  name             = var.name
  description      = var.description
  operating_system = var.operating_system
  rejected_patches = try(var.rejected_patches, false)
  approved_patches = try(var.approved_patches, false)
  approved_patches_enable_non_security = var.approved_patches_enable_non_security


  global_filter {
    key = "CLASSIFICATION"
    values = var.patch_classifications
  }

  dynamic "approval_rule" {
    for_each = var.compliance_levels
    content {
      approve_after_days = var.approve_after_days
      approve_until_date = var.approve_until_date
      enable_non_security = try(var.enable_non_security, true)
      compliance_level = approval_rule.value.compliance_level
    dynamic patch_filter {
      for_each = approval_rule.value.severity
      content {
        key = "SEVERITY"
        values = [patch_filter.value]
        }
      }
    }
  }
    dynamic "source" {
    for_each = var.source_repos != null ? var.source_repos : []

    content {
      name = source.value.name
      products = source.value.products
      configuration = source.value.configuration
    }
  }
}
