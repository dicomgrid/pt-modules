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
}

