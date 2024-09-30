variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.24`)"
  type        = string
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
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

variable "vpc_id" {
  type        = string
  description = "The ID of the Amazon VPC where the Amazon EKS cluster will be created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs where the nodes/node groups will be provisioned."
}

variable "control_plane_subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
  type        = list(string)
}


# variable "iam_role_additional_policies" {
#   description = "The additional IAM policies to attach to the node group's IAM role"
#   type        = map(string)
# }

# variable "eks_managed_node_groups" {
#   type = list(object({
#     ami_type                      = string
#     instance_types                = string
#     iam_role_attach_cni_policy    = bool
#   }))
#   description = "A map"
# }


variable "create_aws_auth_configmap" {
  description = "Whether to create  an AWS ConfigMap to manage Kubernetes authentication  configuration  for the EKS cluster."
  type        = bool
}



variable "manage_aws_auth_configmap" {
  description = "Whether Terraform should manage the  AWS ConfigMap that manages Kubernetes authentication configuration for the EKS cluster"
  type        = bool
}


variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
}
