output "queue_arns" {
  value = { for k, q in aws_sqs_queue.queues : k => q.arn }
}

output "queue_urls" {
  value = { for k, q in aws_sqs_queue.queues : k => q.id }
}
