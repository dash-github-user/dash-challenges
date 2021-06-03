resource "aws_lambda_function" "lambda" {
  function_name = "${var.environment}-${var.project}-${var.name}"
  filename      = var.filename

  memory_size = var.memory_size
  timeout     = var.timeout
  role        = var.role
  runtime     = var.runtime
  handler     = var.handler

  environment {
    variables = {
      SLACK_URL_SSM_PATH = var.slack_url_ssm_path
      SQSQueueNameOnFailure = var.SQSQueueNameOnFailure
      SQSQueueNameOnSuccess = var.SQSQueueNameOnSuccess
      dataset = var.dataset
      sqs_template = var.sqs_template
      webhook_cdr_data_load_link = var.webhook_cdr_data_load_link
      slack_template = var.slack_template
    }
  }

  tags = {
    environment = var.environment
    project     = var.project
    owner       = var.owner
    terraform   = "yes"
  }
}

resource "aws_cloudwatch_event_rule" "lambda" {
  name                = "${var.environment}-${var.project}-${var.name}"
  schedule_expression = var.cron_schedule
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.lambda.name
  target_id = aws_lambda_function.lambda.function_name
  arn       = aws_lambda_function.lambda.arn
}

resource "aws_lambda_permission" "lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda.arn
}

output "lambda_arn" {
  value       = aws_lambda_function.lambda.arn
  description = "Output lambda arn to enable use cases outside of the generic module"
}

