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
  filename         = data.archive_file.first_lambda_file.output_path
  role             = aws_iam_role.first_lambda_role.arn
  source_code_hash = data.archive_file.first_lambda_file.output_base64sha256
}

resource "aws_iam_role" "first_lambda_role" {
  name               = "first-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
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
