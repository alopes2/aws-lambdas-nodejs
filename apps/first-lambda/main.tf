terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "~> 5.83"
    }
  }

  backend "s3" {
    bucket = "terraform-medium-api-notification"
    key    = "aws-lambdas-nodejs/first-lambda/state.tfstate"
  }
}

provider "aws" {}

resource "aws_lambda_function" "first_lambda" {
  function_name    = "first-lambda"
  runtime          = "nodejs22.x"
  handler          = "index.handler"
  filename         = data.archive_file.first_lambda_file.output_path
  role             = aws_iam_role.first_lambda_role.arn
  source_code_hash = data.archive_file.first_lambda_file.output_base64sha256
}

resource "aws_iam_role" "first_lambda_role" {
  name               = "first-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "first_lambda_role_policies" {
  role   = aws_iam_role.first_lambda_role.name
  policy = data.aws_iam_policy_document.policies.json
}

data "archive_file" "first_lambda_file" {
  source_dir  = "src"
  type        = "zip"
  output_path = "first_lambda_payload.zip"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "policies" {
  statement {
    effect = "Allow"
    sid    = "LogToCloudwatch"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}
