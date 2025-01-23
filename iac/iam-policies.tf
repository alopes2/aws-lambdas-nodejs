data "aws_iam_policy_document" "pull_message_from_sqs" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
    ]

    resources = [
      aws_sqs_queue.queue.arn
    ]
  }
}

data "aws_iam_policy_document" "create_dynamodb" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:PutItem",
    ]

    resources = [
      aws_dynamodb_table.nodejs_meetup.arn
    ]
  }
}
