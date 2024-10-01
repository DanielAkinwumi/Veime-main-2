

variable "additional_tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
}

variable "cluster_name" {
  description = "regtech-cluster"
  type        = string
}

variable "cluster_version" {
  description = " cluster version is 1.30"
  type        = string
}

variable "cluster_endpoint_private_access" {
  description = "endpoint private"
  type        = bool
}

variable "cluster_endpoint_public_access" {
  description = "endpoint public"
  type        = bool
}

variable "cluster_addons" {
  type = map(object({
    most_recent = bool
  }))
  default = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
}

variable "create_aws_auth_configmap" {
  description = "Whether to create  an AWS ConfigMap to manage Kubernetes authentication  configuration  for the EKS cluster."
  type        = bool
}

variable "manage_aws_auth_configmap" {
  description = "Whether Terraform should manage the  AWS ConfigMap that manages Kubernetes authentication configuration for the EKS cluster"
  type        = bool
}

variable "vpc_name" {
  type        = string
  description = "Name to be used on all the resources as identifier"
}

variable "cidr" {
  type        = string
  description = "The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
}

variable "azs" {
  default     = []
  type        = list(any)
  description = "A list of availability zones names or ids in the region"
}

variable "private_subnets" {
  default     = []
  type        = list(any)
  description = " A list of private subnets inside the VPC"
}

variable "public_subnets" {
  default     = []
  type        = list(any)
  description = "A list of public subnets inside the VPC"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
}

variable "enable_vpn_gateway" {
  type        = bool
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
}

variable "log_group_name" {
  description = "The name of the CloudWatch log group"
  type        = string
  default     = "regtech-log-group"
}

variable "retention_days" {
  description = "The number of days to retain the logs in the CloudWatch log group"
  type        = number
  default     = 15
}

# variables.tf

variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-west-2" # Replace with your desired region
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "azs" {
  description = "List of Availability Zones."
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs."
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet IDs."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway in the VPC."
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Enable VPN Gateway in the VPC."
  type        = bool
  default     = false
}

variable "additional_tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster."
  type        = string
  default     = "1.21"
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to the EKS cluster endpoint."
  type        = bool
  default     = true
}

variable "cluster_endpoint_private_access" {
  description = "Enable private access to the EKS cluster endpoint."
  type        = bool
  default     = false
}

variable "cluster_addons" {
  description = "List of EKS addons to install."
  type        = list(string)
  default     = []
}

variable "create_aws_auth_configmap" {
  description = "Create the aws-auth ConfigMap."
  type        = bool
  default     = true
}

variable "manage_aws_auth_configmap" {
  description = "Manage the aws-auth ConfigMap."
  type        = bool
  default     = true
}

variable "node_group_desired_size" {
  description = "Desired size of the EKS node group."
  type        = number
  default     = 2
}

variable "node_group_max_size" {
  description = "Maximum size of the EKS node group."
  type        = number
  default     = 3
}

variable "node_group_min_size" {
  description = "Minimum size of the EKS node group."
  type        = number
  default     = 1
}

variable "instance_types" {
  description = "EC2 instance types for the EKS node group."
  type        = list(string)
  default     = ["m5.large"]
}

variable "config_bucket_name" {
  description = "The name of the S3 bucket where AWS Config delivers configuration snapshots and compliance reports."
  type        = string
  default     = "my-terraform-config-bucket" # Replace with your bucket name
}

variable "config_role_name" {
  description = "The name of the IAM role for AWS Config."
  type        = string
  default     = "AWSConfigRole"
}

variable "additional_config_rules" {
  description = "A map of additional AWS Config rules to be created."
  type = map(object({
    name                     = string
    source_identifier        = string
    maximum_execution_frequency = string
  }))
  default = {}
}

variable "config_bucket_name" {
  description = "The name of the S3 bucket for AWS Config logs"
  type        = string
}