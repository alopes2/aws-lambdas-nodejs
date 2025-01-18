module "api_gateway_lambda" {
  source = "./modules/lambda"
  name   = "api-gateway"
}
