resource "aws_lambda_layer_version" "layer" {
  compatible_runtimes = ["nodejs22.x"]
  layer_name          = "nodejs-meetup-layer"
  s3_bucket           = aws_s3_bucket.layers.bucket
  # s3_key              = data.aws_s3_object.layer.key
  # source_code_hash    = base64sha256(data.aws_s3_object.layer.last_modified)
  # s3_object_version = aws_s3_bucket_key  // This is a better approach then the source_code_hash, but requires your s3_bucket to have version enabled
  # filename          = "layers/layer.zip" // This you can make use of the "archive_file" data source, or zip for yourself
}

# With this setup, you need to first create the bucket, then the key in the bucket
# Only then you can create the lambda layer version
# data "aws_s3_object" "layer" {
#   key    = "nodejs-meetup.zip"
#   bucket = aws_s3_bucket.layers.bucket
# }
