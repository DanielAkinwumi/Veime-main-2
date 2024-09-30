

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

