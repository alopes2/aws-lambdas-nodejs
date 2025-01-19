module "api_gateway_lambda" {
  source = "./modules/lambda"
  name   = "api-gateway"
}

module "sqs_sns_lambda" {
  source   = "./modules/lambda"
  name     = "sqs-sns"
  policies = [data.aws_iam_policy_document.pull_message_from_sqs.json]
}
resource "aws_lambda_event_source_mapping" "email_notification_trigger" {
  event_source_arn = aws_sqs_queue.queue.arn
  function_name    = module.sqs_sns_lambda.name
  enabled          = true
}

resource "aws_lambda_permission" "sns_permission_lambda" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.sqs_sns_lambda.arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.topic.arn
}
