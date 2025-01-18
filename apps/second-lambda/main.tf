terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "~> 5.83"
    }
  }

  backend "s3" {
    bucket = "terraform-medium-api-notification"
    key    = "aws-lambdas-nodejs/second-lambda/state.tfstate"
  }
}

provider "aws" {}

resource "aws_lambda_function" "second_lambda" {
  function_name    = "second-lambda"
  runtime          = "nodejs22.x"
  handler          = "index.handler"
  filename         = data.archive_file.second_lambda_file.output_path
  role             = aws_iam_role.second_lambda_role.arn
  source_code_hash = data.archive_file.second_lambda_file.output_base64sha256
}

resource "aws_iam_role" "second_lambda_role" {
  name               = "second-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "second_lambda_file" {
  source_dir  = "build"
  type        = "zip"
  output_path = "second_lambda_payload.zip"
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
