# modules/compliance/outputs.tf

output "securityhub_account_id" {
  description = "The account ID for AWS Security Hub"
  value       = aws_securityhub_account.main.id
}

output "config_recorder_name" {
  description = "The name of the AWS Config recorder"
  value       = aws_config_configuration_recorder.main.name
}
