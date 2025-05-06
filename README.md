# AWS Event-Driven Architecture with Terraform

This project sets up an event-driven architecture in AWS using Terraform with the following components:

- **API Gateway**: exposes a `/notifications` endpoint.
- **SNS Topic**: receives messages from the API Gateway.
- **SQS Queues**: 3 queues subscribed to the SNS topic.
- **Lambda Functions**: triggered by SQS messages, implemented in .NET 8.
- **IAM Roles**: secure permissions for Lambda to access SQS, SNS, and CloudWatch.

---

## 🛠️ Prerequisites

- [AWS CLI configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
- Terraform ≥ 1.4
- .NET SDK 8.0
- Visual Studio Code (with C# Dev Kit, optional)
- Zip utility (for packaging lambdas)

---

## 🚀 Deployment Steps

### 1. Initialize Terraform

```bash
terraform init
