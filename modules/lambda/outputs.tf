output "lambda_arns" {
  value = { for k, f in aws_lambda_function.handlers : k => f.arn }
}
