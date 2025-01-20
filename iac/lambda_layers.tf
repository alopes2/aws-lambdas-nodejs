resource "aws_lambda_layer_version" "layer" {
  compatible_runtimes = ["nodejs22.x"]
  layer_name          = "nodejs-meetup-layer"
  s3_bucket           = aws_s3_bucket.layers.bucket
  s3_key              = "nodejs-meetup.zip"
  # filename            = "layers/layer.zip"
  # source_code_hash    = filebase64sha256("layers/layer.zip")
}
