variable "queue_names" {
  type        = list(string)
  description = "Names of the SQS queues to create"
}

variable "sns_topic_arn" {
  type        = string
  description = "ARN of the SNS topic to subscribe to"
}
