resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = "API Gateway to receive device notifications"
}

resource "aws_api_gateway_resource" "notifications" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "notifications"
}

resource "aws_api_gateway_method" "post" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.notifications.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "sns" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.notifications.id
  http_method             = aws_api_gateway_method.post.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = "arn:aws:apigateway:${var.region}:sns:action/Publish"
  credentials             = var.apigw_role_arn

  request_templates = {
    "application/json" = <<EOF
{
  "TopicArn": "${var.sns_topic_arn}",
  "Message": "$util.escapeJavaScript($input.body)"
}
EOF
  }

  passthrough_behavior = "NEVER"
}

resource "aws_api_gateway_method_response" "post_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.notifications.id
  http_method = aws_api_gateway_method.post.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "integration_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.notifications.id
  http_method = aws_api_gateway_method.post.http_method
  status_code = aws_api_gateway_method_response.post_200.status_code

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_deployment" "this" {
  depends_on = [
    aws_api_gateway_integration.sns
  ]
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_stage" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
  stage_name    = var.stage_name

  variables = {
    example_variable = "example_value"
  }
}

