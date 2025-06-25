data "archive_file" "lambda_archive" {
  count       = var.function_code != null ? 1 : 0
  type        = "zip"
  source_file = "${path.module}/../lambda-tools/${var.function_code}"
  output_path = var.archive_file
}
