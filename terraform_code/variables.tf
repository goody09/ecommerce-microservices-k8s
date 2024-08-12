variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "name" {
  description = "Cluster name"
  default     = "goody-sock-shop"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.123.0.0/16"
}

variable "azs" {
  description = "Availability zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  default     = ["10.123.1.0/24", "10.123.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  default     = ["10.123.3.0/24", "10.123.4.0/24"]
}

