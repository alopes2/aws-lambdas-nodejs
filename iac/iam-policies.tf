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
