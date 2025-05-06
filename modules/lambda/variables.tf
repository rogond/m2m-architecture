variable "lambdas" {
  description = "Map of lambda function configs"
  type = map(object({
    handler   : string
    runtime   : string
    timeout   : number
    memory    : number
    filename  : string
    role_arn  : string
    sqs_arn   : string
  }))
}
