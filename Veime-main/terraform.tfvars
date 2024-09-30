
# General Values

additional_tags = {
  created_by  = "terraform"
  Environment = "dev"
}


# networking Values

vpc_name           = "regtech"
cidr               = "10.0.0.0/16"
azs                = ["eu-west-2a", "eu-west-2b"]
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets     = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
enable_nat_gateway = true
enable_vpn_gateway = true



# # EKS Values

cluster_version                 = "1.30"
cluster_name                    = "regtech-cluster"
cluster_endpoint_private_access = true
cluster_endpoint_public_access  = false
cluster_addons = {
  coredns = {
    most_recent = true
    enabled     = true
    version     = "v1.9.3-eksbuild.2"
  }
  kube-proxy = {
    most_recent = true
    enabled     = true
    version     = "v1.25.6-eksbuild.1"
  }
  vpc-cni = {
    most_recent = true
    enabled     = true
    version     = "v1.12.2-eksbuild.1"
  }
}

create_aws_auth_configmap = true
manage_aws_auth_configmap = true
# enable_irsa               = true

