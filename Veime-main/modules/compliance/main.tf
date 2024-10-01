# modules/compliance/main.tf

# Enable AWS Security Hub for your account
resource "aws_securityhub_account" "main" {}

# Subscribe to the CIS AWS Foundations Benchmark standard
resource "aws_securityhub_standards_subscription" "cis" {
  depends_on   = [aws_securityhub_account.main]
  standards_arn = "arn:aws:securityhub:::standards/cis-aws-foundations-benchmark/v/1.2.0"
}

# Subscribe to the PCI-DSS standard
resource "aws_securityhub_standards_subscription" "pci_dss" {
  depends_on   = [aws_securityhub_account.main]
  standards_arn = "arn:aws:securityhub:::standards/pci-dss/v/3.2.1"
}

# AWS Config Rule for PCI-DSS compliance (Managed Rule)
resource "aws_config_config_rule" "pci_dss" {
  name = "pci-dss-3-2-1"

  source {
    owner             = "AWS"
    source_identifier = "PCI.DSS.3.2.1"
  }

  maximum_execution_frequency = "TwentyFour_Hours"
}

# Additional AWS Config Rule Example: Ensure S3 Buckets are Encrypted
resource "aws_config_config_rule" "s3_bucket_encryption_enabled" {
  name = "s3-bucket-server-side-encryption-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }

  maximum_execution_frequency = "TwentyFour_Hours"
}

# Enable AWS Config Configuration Recorder
resource "aws_config_configuration_recorder" "main" {
  name     = "config-recorder"
  role_arn = aws_iam_role.config_role.arn

  recording_group {
    all_supported = true
    include_global_resource_types = true
  }
}

# AWS Config Delivery Channel
resource "aws_config_delivery_channel" "main" {
  name           = "config-delivery-channel"
  s3_bucket_name = var.config_bucket_name

  depends_on = [aws_config_configuration_recorder.main]
}

# IAM Role for AWS Config
resource "aws_iam_role" "config_role" {
  name = "AWSConfigRole"

  assume_role_policy = data.aws_iam_policy_document.config_assume_role_policy.json
}

data "aws_iam_policy_document" "config_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }
}

# Attach AWS Managed Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "config_role_policy_attachment" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}
