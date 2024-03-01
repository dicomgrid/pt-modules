data "archive_file" "lambda_archive" {
  count       = var.function_code == null ? 0 : 1
  type        = "zip"
  source_file = "${path.module}/../lambda-tools/${var.function_code}"
  output_path = var.archive_file
}

resource "aws_lambda_function" "lambda_function" {
  architectures    = var.architectures
  function_name    = var.function_name
  handler          = var.handler
  role             = var.role
  runtime          = var.runtime
  filename         = var.archive_file
  timeout          = var.timeout
  source_code_hash = filebase64(var.archive_file)

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  count = var.create_log_group == null ? 0 : 1
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_in_days

  tags = var.tags
}