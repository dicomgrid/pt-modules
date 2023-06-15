resource "aws_ssm_patch_baseline" "pb-pacs-centos" {
  name             = var.name
  description      = var.description
  operating_system = "CENTOS"
  rejected_patches = var.rejected_patches
  global_filter {
    key = "CLASSIFICATION"
    values = var.patch_classifications
  }
  dynamic "approval_rule" {
    for_each = var.compliance_levels
    content {
      approve_after_days = var.approval_days
      enable_non_security = true
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
    for_each = var.source_repos

    content {
      name = source.value.name
      products = source.value.products
      configuration = source.value.repo
    }
  }
}
