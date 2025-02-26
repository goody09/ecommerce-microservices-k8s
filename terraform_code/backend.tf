terraform {
  backend "s3" {
    bucket         = "microservice-cluster-terraform-state-bucket"
    key            = "terraform/state"
    region         = "us-east-1"
    dynamodb_table = "microservice-cluster-terraform-locks"
  }
}
