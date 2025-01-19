resource "aws_sns_topic" "topic" {
  name = "nodejs-meetup"
}

resource "aws_sqs_queue" "queue" {
  name = "nodejs-meetup"
}
