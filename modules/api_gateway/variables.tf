variable "api_name" {
  type        = string
  description = "Name of the API"
}

variable "sns_topic_arn" {
  type        = string
  description = "ARN of the SNS topic to publish to"
}

variable "stage_name" {
  type        = string
  default     = "dev"
  description = "Deployment stage name"
}

variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "apigw_role_arn" {
  type = string
}

variable "log_group_arn" {
  description = "ARN of the CloudWatch Log Group for API Gateway access logs"
  type        = string
}

variable "logs_role_arn" {
  description = "IAM role ARN for API Gateway to push logs to CloudWatch"
  type        = string
}

