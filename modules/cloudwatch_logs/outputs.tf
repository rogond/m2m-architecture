output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group for API Gateway"
  value       = aws_cloudwatch_log_group.apigateway_logs.name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group for API Gateway"
  value       = aws_cloudwatch_log_group.apigateway_logs.arn
}

output "log_group_arn" {
  value = aws_cloudwatch_log_group.apigateway_logs.arn
}