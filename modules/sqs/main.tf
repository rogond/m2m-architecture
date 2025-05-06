resource "aws_sqs_queue" "queues" {
  for_each = toset(var.queue_names)

  name = each.value
}

resource "aws_sns_topic_subscription" "subscriptions" {
  for_each = aws_sqs_queue.queues

  topic_arn = var.sns_topic_arn
  protocol  = "sqs"
  endpoint  = each.value.arn

  raw_message_delivery = true
}

resource "aws_sqs_queue_policy" "allow_sns" {
  for_each = aws_sqs_queue.queues

  queue_url = each.value.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "Allow-SNS-SendMessage",
        Effect    = "Allow",
        Principal = "*",
        Action    = "SQS:SendMessage",
        Resource  = each.value.arn,
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = var.sns_topic_arn
          }
        }
      }
    ]
  })
}

