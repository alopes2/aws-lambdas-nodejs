terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "~> 5.83"
    }
  }

  backend "s3" {
    bucket = "terraform-medium-api-notification"
    key    = "aws-lambdas-nodejs/state.tfstate"
  }
}

provider "aws" {}
