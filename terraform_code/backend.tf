terraform {
  backend "s3" {
    bucket         = "sock-shop-terraform-state-bucket"
    key            = "terraform/state"
    region         = "us-east-1"
    dynamodb_table = "sock-shop-terraform-locks"
  }
}
