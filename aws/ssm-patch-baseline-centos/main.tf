resource "aws_ssm_patch_baseline" "pb-linux" {
  name             = var.name
  description      = var.description
  operating_system = "CENTOS"
  rejected_patches = [jsonencode(var.rejected_patches)]
  }