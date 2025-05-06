resource "aws_lambda_function" "handlers" {
  for_each = var.lambdas

  function_name = each.key
  role          = each.value.role_arn
  handler       = each.value.handler
  runtime       = each.value.runtime
  timeout       = each.value.timeout
  memory_size   = each.value.memory

  filename         = each.value.filename
  source_code_hash = filebase64sha256(each.value.filename)
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  for_each = var.lambdas

  event_source_arn = each.value.sqs_arn
  function_name    = aws_lambda_function.handlers[each.key].arn
  batch_size       = 10
  enabled          = true
}

