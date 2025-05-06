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


