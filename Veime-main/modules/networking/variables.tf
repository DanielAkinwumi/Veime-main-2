variable "name" {
  type = string
  description = "Name to be used on all the resources as identifier"
}

variable "cidr" {
  type = string
  description = "The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
}

variable "azs" {
    default = []
  type = list
  description = "A list of availability zones names or ids in the region"
}

variable "private_subnets" {
    default = []
  type = list
  description = " A list of private subnets inside the VPC"
}

variable "public_subnets" {
  default = []
  type = list
  description = "A list of public subnets inside the VPC"
}

variable "enable_nat_gateway" {
  type = bool
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
}

variable "enable_vpn_gateway" {
  type = bool
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
}

variable "tags" {
    default = {}
  type = map
  description = "A map of tags to add to all resources"
}