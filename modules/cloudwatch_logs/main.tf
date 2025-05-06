resource "aws_cloudwatch_log_group" "apigateway_logs" {
  name              = "/aws/apigateway/${var.api_name}"
  retention_in_days = 14
}