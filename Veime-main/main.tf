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
      Name = "_eks"
  }, )
}

resource "aws_eks_node_group" "regtech_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "regtech_node"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = module.vpc.private_subnets
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  instance_types = ["m5.large"]
}

resource "aws_iam_role" "node_group" {
  name = "eks-node-group-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

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
      Name = "VPC"
  }, )
}

module "deployment" {
  source = "./modules/deployment"

  depends_on = [module.eks]
}

