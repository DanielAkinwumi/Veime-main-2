# modules/compliance/variables.tf

variable "config_bucket_name" {
  description = "The name of the S3 bucket for AWS Config logs"
  type        = string
}
