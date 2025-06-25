resource "aws_lambda_function" "lambda_function" {
  architectures    = var.architectures
  function_name    = var.function_name
  handler          = var.handler != null ? var.handler : "lambda_function.lambda_handler"
  layers           = var.layer_name != null ? [aws_lambda_layer_version.lambda_layer[0].arn] : []
  role             = var.role
  runtime          = var.runtime
  timeout          = var.timeout
  filename         = var.s3_bucket == null ? var.archive_file : null
  s3_bucket        = var.s3_bucket
  s3_key           = var.s3_key
  source_code_hash = var.function_code != null ? data.archive_file.lambda_archive[0].output_base64sha256 : null
  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}
resource "aws_lambda_permission" "allow_eventbridge" {
  count         = var.trigger_source_arn == null ? 0 : 1
  statement_id  = var.trigger_statement_id
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = var.trigger_principal != null ? var.trigger_principal : "events.amazonaws.com"
  source_arn    = var.trigger_source_arn
}


## filename statement is to maintain backwards compatibility and probably needs simplification.
## It allows the filename OR s3_bucket/s3_key to be specified but not both.
resource "aws_lambda_layer_version" "lambda_layer" {
  count      = var.layer_name == null ? 0 : 1
  layer_name = var.layer_name
  filename   = (var.layer_s3_bucket != null && var.layer_s3_key != null) ? null : "${path.module}/../lambda-tools/layers/${var.layer_name}.zip"
  s3_bucket  = var.layer_s3_bucket
  s3_key     = var.layer_s3_key

  compatible_runtimes = local.runtime_map[var.layer_runtime]
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  count             = var.create_log_group == null ? 0 : 1
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_in_days

  tags = var.tags
}
