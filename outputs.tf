output "api_id" {
  description = "Invoke URL for the API Gateway"
  value       = module.api_gateway.api_id
}

output "api_gateway_url" {
  description = "Invoke URL for the API Gateway"
  value       = module.api_gateway.invoke_url
}
