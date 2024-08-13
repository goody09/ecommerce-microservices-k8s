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

# S3 bucket name for Terraform state
variable "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state."
  type        = string
}

# DynamoDB table name for Terraform state locking
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking."
  type        = string
}

variable "terraform_state_key" {
  description = "Key path within the S3 bucket to store the Terraform state file"
  type        = string
}

