resource "aws_cloudwatch_log_group" "api_gateway_logs" {
  name = "/aws/api-gateway/${var.api_gateway_name}-logs"
}

resource "aws_cloudwatch_log_stream" "api_gateway_log_stream" {
  log_group_name = aws_cloudwatch_log_group.api_gateway_logs.name
  name           = "api-gateway-log-stream"
}