provider "aws" {
  region = "eu-west-2"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.log_group_name
  retention_in_days = var.retention_days
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "regtech-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}