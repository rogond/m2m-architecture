output "lambda_role_arn" {
  value = aws_iam_role.lambda_exec.arn
}

output "apigw_to_sns_role_arn" {
  value = aws_iam_role.apigw_to_sns.arn
}