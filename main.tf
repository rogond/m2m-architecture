variable "api_name" {
  description = "Shared name for the API Gateway and logs"
  default     = "DeviceNotificationsAPI"
}

module "sns" {
  source     = "./modules/sns"
  topic_name = "device-notifications-topic"
}

module "cloudwatch" {
  source           = "./modules/cloudwatch"
  api_gateway_name = module.api_gateway.api_id
}

module "cloudwatch_logs" {
  source   = "./modules/cloudwatch_logs"
  api_name = var.api_name
}

module "api_gateway" {
  source         = "./modules/api_gateway"
  api_name       = "DeviceNotificationsAPI"
  sns_topic_arn  = module.sns.topic_arn
  stage_name     = "dev"
  region         = "us-east-1"
  apigw_role_arn = module.iam.apigw_to_sns_role_arn
  log_group_arn  = module.cloudwatch_logs.log_group_arn
  logs_role_arn  = module.iam.apigw_logs_role_arn
}

module "sqs" {
  source        = "./modules/sqs"
  queue_names   = ["handler-a-queue", "handler-b-queue", "handler-c-queue"]
  sns_topic_arn = module.sns.topic_arn
}

module "lambda" {
  source = "./modules/lambda"

  lambdas = {
    handler_a = {
      handler  = "Function1::Function1.FunctionHandler::Handle"
      runtime  = "dotnet8"
      timeout  = 10
      memory   = 256
      filename = "${path.module}/lambda_src/Function1.zip"
      role_arn = module.iam.lambda_role_arn
      sqs_arn  = module.sqs.queue_arns["handler-a-queue"]
    }
    handler_b = {
      handler  = "Function2::Function2.FunctionHandler::Handle"
      runtime  = "dotnet8"
      timeout  = 10
      memory   = 256
      filename = "${path.module}/lambda_src/Function2.zip"
      role_arn = module.iam.lambda_role_arn
      sqs_arn  = module.sqs.queue_arns["handler-b-queue"]
    }
    handler_c = {
      handler  = "Function3::Function3.FunctionHandler::Handle"
      runtime  = "dotnet8"
      timeout  = 10
      memory   = 256
      filename = "${path.module}/lambda_src/Function3.zip"
      role_arn = module.iam.lambda_role_arn
      sqs_arn  = module.sqs.queue_arns["handler-c-queue"]
    }
  }
}

module "iam" {
  source        = "./modules/iam"
  sns_topic_arn = module.sns.topic_arn
}

resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = module.iam.apigw_cloudwatch_role_arn
}