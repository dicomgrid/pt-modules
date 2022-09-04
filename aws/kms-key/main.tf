resource "aws_kms_key" "main" {
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.main.key_id
}