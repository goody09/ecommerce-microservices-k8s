# AWS region
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Cluster name
variable "name" {
  description = "Cluster name"
  type        = string
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.123.0.0/16"
}

# Availability zones
variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Public subnet CIDRs
variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.123.1.0/24", "10.123.2.0/24"]
}

# Private subnet CIDRs
variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.123.3.0/24", "10.123.4.0/24"]
}
