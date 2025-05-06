output "lambda_role_arn" {
  value = aws_iam_role.lambda_exec.arn
}

output "apigw_to_sns_role_arn" {
  value = aws_iam_role.apigw_to_sns.arn
}

output "apigw_cloudwatch_role_arn" {
  value = aws_iam_role.apigw_cloudwatch.arn
}

output "apigw_logs_role_arn" {
  value = aws_iam_role.apigw_cloudwatch_logs.arn
}