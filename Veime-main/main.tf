# main.tf

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source = "./modules/networking"
  name   = var.vpc_name

  cidr            = var.cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.vpc_name}-vpc"
    }
  )
}

# Create an S3 bucket for AWS Config
resource "aws_s3_bucket" "config_bucket" {
  bucket = var.config_bucket_name

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.vpc_name}-config-bucket"
    }
  )
}

# EKS Module
module "eks" {
  source                          = "./modules/eks"
  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_addons                  = var.cluster_addons
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  control_plane_subnet_ids        = module.vpc.private_subnets
  create_aws_auth_configmap       = var.create_aws_auth_configmap
  manage_aws_auth_configmap       = var.manage_aws_auth_configmap
  tags = merge(
    var.additional_tags,
    {
      Name = "${var.cluster_name}-eks"
    }
  )
}

# IAM Role for EKS Node Group
resource "aws_iam_role" "node_group" {
  name = "${var.cluster_name}-eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach Managed Policies to Node Group Role
resource "aws_iam_role_policy_attachment" "node_group_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.node_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node_group_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.node_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "node_group_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.node_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# EKS Node Group
resource "aws_eks_node_group" "regtech_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "regtech-node-group"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = module.vpc.private_subnets

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  instance_types = var.instance_types

  tags = merge(
    var.additional_tags,
    {
      Name = "regtech-node-group"
    }
  )
}

# Compliance Module
module "compliance" {
  source             = "./modules/compliance"
  config_bucket_name = aws_s3_bucket.config_bucket.bucket

}

# Deployment Module
module "deployment" {
  source       = "./modules/deployment"
  # ... other necessary variables
  depends_on   = [module.eks]
}

# CloudWatch Log Module
module "cloudwatch_log" {
  source = "./modules/cloudwatch_log"
  # ... necessary configurations
}
