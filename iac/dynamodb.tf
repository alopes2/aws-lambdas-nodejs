resource "aws_dynamodb_table" "nodejs_meetup" {
  name           = "nodejs-meetup"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "S"
  }
}
