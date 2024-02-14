# Creates a Regional EFS File System
resource "aws_efs_file_system" "main" {
  creation_token = var.name
  encrypted      = var.encrypted
  kms_key_id     = var.kms_key_id

  performance_mode                = var.performance_mode
  throughput_mode                 = var.throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps

  lifecycle_policy {
    transition_to_ia = var.transition_to_ia
  }

  tags = local.tags
}

resource "aws_efs_backup_policy" "main" {
  file_system_id = aws_efs_file_system.main.id

  backup_policy {
    status = var.backup
  }
}